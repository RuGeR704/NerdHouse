package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rimuoviDalCarrello")
public class RimuoviCarrelloServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente != null) {
            int idUtente = utente.getId();
            CarrelloDAO carrelloDAO = new CarrelloDAO();
            ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();
            Carrello carrello = carrelloDAO.doRetrieveByUserId(idUtente);
            if (carrello != null) {
                contenutoDAO.doDelete(carrello.getIdCarrello(), idProdotto);
            }
        } else {
            List<ContenutoCarrello> carrelloGuest = (List<ContenutoCarrello>) session.getAttribute("carrelloGuest");
            if (carrelloGuest != null) {
                carrelloGuest.removeIf(c -> c.getIdProdotto() == idProdotto);
                session.setAttribute("carrelloGuest", carrelloGuest);
            }
        }
        response.sendRedirect("carrello");
    }
}
