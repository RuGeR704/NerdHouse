package Controller;

import Model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/aggiungiCarrello")
public class AggiungiCarrelloServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));

        if (utente != null) {
            int idUtente = utente.getId();
            CarrelloDAO carrelloDAO = new CarrelloDAO();
            ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();
            Carrello carrello = carrelloDAO.doRetrieveByUserId(idUtente);
            if (carrello == null) {
                carrello = new Carrello();
                carrello.setIdUtente(idUtente);
                carrello.setQuantità(0);
                carrello.setTotaleSpesa(0.0);
                carrelloDAO.doSave(carrello);
                carrello = carrelloDAO.doRetrieveByUserId(idUtente);
            }
            var contenuti = contenutoDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());
            boolean prodottoGiaPresente = false;
            for (var c : contenuti) {
                if (c.getIdProdotto() == idProdotto) {
                    contenutoDAO.doUpdate(carrello.getIdCarrello(), idProdotto, c.getQuantita() + 1);
                    prodottoGiaPresente = true;
                    break;
                }
            }
            if (!prodottoGiaPresente) {
                contenutoDAO.doSave(carrello.getIdCarrello(), idProdotto, 1);
            }
        } else {
            List<ContenutoCarrello> carrelloGuest = (List<ContenutoCarrello>) session.getAttribute("carrelloGuest");
            if (carrelloGuest == null) carrelloGuest = new ArrayList<>();
            boolean trovato = false;
            for (ContenutoCarrello c : carrelloGuest) {
                if (c.getIdProdotto() == idProdotto) {
                    c.setQuantita(c.getQuantita() + 1);
                    trovato = true;
                    break;
                }
            }
            if (!trovato) {
                ContenutoCarrello nuovo = new ContenutoCarrello();
                nuovo.setIdProdotto(idProdotto);
                nuovo.setQuantita(1);
                Prodotto p = new ProdottoDAO().doRetrieveById(idProdotto);
                nuovo.setProdotto(p);
                carrelloGuest.add(nuovo);
            }
            session.setAttribute("carrelloGuest", carrelloGuest);
        }
        response.sendRedirect("carrello");
    }

}