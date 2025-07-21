package Controller;

import Model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/quantitaCarrello")
public class QuantitaCarrelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        int quantitaTotale = 0;

        if (utente != null) {
            CarrelloDAO carrelloDAO = new CarrelloDAO();
            ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();
            Carrello carrello = carrelloDAO.doRetrieveByUserId(utente.getId());
            if (carrello != null) {
                List<ContenutoCarrello> contenuti = contenutoDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());
                quantitaTotale = contenuti.stream().mapToInt(ContenutoCarrello::getQuantita).sum();
            }
        } else {
            List<ContenutoCarrello> carrelloGuest = (List<ContenutoCarrello>) session.getAttribute("carrelloGuest");
            if (carrelloGuest != null) {
                quantitaTotale = carrelloGuest.stream().mapToInt(ContenutoCarrello::getQuantita).sum();
            }
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"count\": " + quantitaTotale + "}");
        out.flush();
    }
}
