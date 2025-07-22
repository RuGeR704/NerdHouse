package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Iterator;
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
                ContenutoCarrello contenuto = contenutoDAO.doRetrieveByCarrelloAndProdotto(carrello.getIdCarrello(), idProdotto);
                if (contenuto != null) {
                    int quantita = contenuto.getQuantita();
                    if (quantita > 1) {
                        contenuto.setQuantita(quantita - 1);
                        contenutoDAO.doUpdate(carrello.getIdCarrello(), idProdotto, contenuto.getQuantita());
                    } else {
                        contenutoDAO.doDelete(carrello.getIdCarrello(), idProdotto);
                    }
                }
            }
        } else {
            List<ContenutoCarrello> carrelloGuest = (List<ContenutoCarrello>) session.getAttribute("carrelloGuest");
            if (carrelloGuest != null) {
                for (Iterator<ContenutoCarrello> it = carrelloGuest.iterator(); it.hasNext(); ) {
                    ContenutoCarrello c = it.next();
                    if (c.getIdProdotto() == idProdotto) {
                        if (c.getQuantita() > 1) {
                            c.setQuantita(c.getQuantita() - 1);
                        } else {
                            it.remove();
                        }
                        break;
                    }
                }
                session.setAttribute("carrelloGuest", carrelloGuest);
            }
        }
        response.sendRedirect("carrello");
    }

}