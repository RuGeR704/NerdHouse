package Controller;

import Model.Carrello;
import Model.CarrelloDAO;
import Model.ContenutoCarrelloDAO;
import Model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/aggiungiCarrello")
public class AggiungiCarrelloServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        int idUtente = utente.getId();

        CarrelloDAO carrelloDAO = new CarrelloDAO();
        ContenutoCarrelloDAO contenutoDAO = new ContenutoCarrelloDAO();

        // Recupera o crea il carrello
        Carrello carrello = carrelloDAO.doRetrieveByUserId(idUtente);
        if (carrello == null) {
            carrello = new Carrello();
            carrello.setIdUtente(idUtente);
            carrello.setQuantità(0);
            carrello.setTotaleSpesa(0.0);
            carrelloDAO.doSave(carrello);
            carrello = carrelloDAO.doRetrieveByUserId(idUtente);
        }

        // Aggiungi il prodotto al carrello: controlla se già presente
        var contenuti = contenutoDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());
        boolean prodottoGiaPresente = false;
        for (var c : contenuti) {
            if (c.getIdProdotto() == idProdotto) {
                // Prodotto già presente → aggiorna quantità
                contenutoDAO.doUpdate(carrello.getIdCarrello(), idProdotto, c.getQuantita() + 1);
                prodottoGiaPresente = true;
                break;
            }
        }

        if (!prodottoGiaPresente) {
            contenutoDAO.doSave(carrello.getIdCarrello(), idProdotto, 1);
        }

        // Redirect al catalogo
        response.sendRedirect("catalogo");
    }
}