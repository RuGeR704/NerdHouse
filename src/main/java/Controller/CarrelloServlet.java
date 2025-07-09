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
        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idUtente = utente.getId();
        CarrelloDAO carrelloDAO = new CarrelloDAO();
        ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        Carrello carrello = carrelloDAO.doRetrieveByUserId(idUtente);
        List<ContenutoCarrello> contenuti = new ArrayList<>();
        List<Prodotto> prodotti = new ArrayList<>();

        if (carrello != null) {
            contenuti = contenutoDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());
            for (ContenutoCarrello c : contenuti) {
                Prodotto p = prodottoDAO.doRetrieveById(c.getIdProdotto());
                prodotti.add(p);
            }
        }

        request.setAttribute("carrello", carrello);
        request.setAttribute("contenuti", contenuti);
        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/jsp/carrello.jsp").forward(request, response);
    }
}