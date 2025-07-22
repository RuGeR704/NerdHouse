package Controller;

import Model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("user");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Dati form
        String indirizzo = request.getParameter("indirizzo");
        String pagamento = request.getParameter("pagamento");
        Timestamp dataOrdine = new Timestamp(new Date().getTime());

        // DAO
        CarrelloDAO carrelloDAO = new CarrelloDAO();
        ContenutoCarrelloDAO contenutoCarrelloDAO = new ContenutoCarrelloDAO();
        OrdineDAO ordineDAO = new OrdineDAO();
        ContenutoOrdineDAO contenutoOrdineDAO = new ContenutoOrdineDAO();

        Carrello carrello = carrelloDAO.doRetrieveByUserId(utente.getId());
        List<ContenutoCarrello> prodottiCarrello = contenutoCarrelloDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());

        if (prodottiCarrello == null || prodottiCarrello.isEmpty()) {
            request.setAttribute("errore", "Carrello vuoto");
            request.getRequestDispatcher("/WEB-INF/checkout.jsp").forward(request, response);
            return;
        }

        // Crea ordine
        Ordine ordine = new Ordine();
        ordine.setIdUtente(utente.getId());
        ordine.setPagamento(pagamento);
        ordine.setIndirizzoOrdine(indirizzo);
        ordine.setStato("In elaborazione");
        ordine.setDataOrdine(dataOrdine);
        int idOrdine = ordineDAO.doSave(ordine);

        // Aggiunge contenuti ordine
        for (ContenutoCarrello item : prodottiCarrello) {
            ContenutoOrdine contenuto = new ContenutoOrdine();
            contenuto.setIdOrdine(idOrdine);
            contenuto.setIdProdotto(item.getIdProdotto());
            contenuto.setQuantita(item.getQuantita());
            contenutoOrdineDAO.doSave(contenuto);
        }

        // Svuota carrello
        contenutoCarrelloDAO.doDeleteAllByCarrelloId(carrello.getIdCarrello());
        carrello.setQuantità(0);
        carrello.setTotaleSpesa(0.0);
        carrelloDAO.doUpdate(carrello);

        request.setAttribute("messaggio", "Ordine effettuato con successo!");
        request.getRequestDispatcher("/WEB-INF/ordineConfermato.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect("checkout.jsp");
    }
}