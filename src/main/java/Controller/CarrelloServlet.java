package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        List<ContenutoCarrello> contenuti = new ArrayList<>();

        if (utente != null) {
            int idUtente = utente.getId();
            CarrelloDAO carrelloDAO = new CarrelloDAO();
            ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();
            ProdottoDAO prodottoDAO = new ProdottoDAO();

            Carrello carrello = carrelloDAO.doRetrieveByUserId(idUtente);
            if (carrello != null) {
                contenuti = contenutoDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());
                for (ContenutoCarrello c : contenuti) {
                    Prodotto p = prodottoDAO.doRetrieveById(c.getIdProdotto());
                    c.setProdotto(p);
                }
            }
        } else {
            // Carrello guest dalla sessione
            contenuti = (List<ContenutoCarrello>) session.getAttribute("carrelloGuest");
            if (contenuti == null) contenuti = new ArrayList<>();
        }

        request.setAttribute("contenuti", contenuti);
        request.getRequestDispatcher("/WEB-INF/carrello.jsp").forward(request, response);
    }
}