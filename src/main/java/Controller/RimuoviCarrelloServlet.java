package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/rimuoviDalCarrello")
public class RimuoviCarrelloServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));

        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idUtente = utente.getId();
        CarrelloDAO carrelloDAO = new CarrelloDAO();
        ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();

        Carrello carrello = carrelloDAO.doRetrieveByUserId(idUtente);
        if (carrello != null) {
            contenutoDAO.doDelete(carrello.getIdCarrello(), idProdotto);
        }

        response.sendRedirect("carrello");
    }
}