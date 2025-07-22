package Controller;

import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/userServlet")
public class UserAreaServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("utente") != null) {

            Utente utente = (Utente) session.getAttribute("utente");

            String sezione = request.getParameter("sezione");

            if ("wishlist".equals(sezione)) {
                // ✳️ GESTIONE WISHLIST
                ContenutoWishlistDAO contenutoWishlistDAO = new ContenutoWishlistDAO();

                try {
                    int idWishlist = contenutoWishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
                    List<Prodotto> prodotti = contenutoWishlistDAO.doRetrieveProdottiByIdWishList(idWishlist);
                    request.setAttribute("prodotti", prodotti);
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("prodotti", new ArrayList<>()); // fallback sicuro
                }
            }

            OrdineDAO ordineDAO = new OrdineDAO();

            List<OrdineDettaglio> ordini = ordineDAO.doRetrieveByUtenteId(utente.getId());

            MetodoPagamentoDAO dao = new MetodoPagamentoDAO();

            List<MetodoPagamento> metodi = new ArrayList<>();

            try {
                metodi = dao.doRetrievebyUtente(utente);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (sezione == null) sezione = "dati";
            request.setAttribute("sezione", sezione);

            request.setAttribute("metodi", metodi);
            request.setAttribute("ordini", ordini);
            request.setAttribute("utente", utente);

            request.getRequestDispatcher("/WEB-INF/AreaUtente.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}


