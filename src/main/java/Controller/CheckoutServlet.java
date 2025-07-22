package Controller;

import Model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("userServlet");
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
        request.getRequestDispatcher("/WEB-INF/confermaordine.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String totaleStr = request.getParameter("totale");

        totaleStr = totaleStr.replace(',', '.');
        float totale =  Float.parseFloat(totaleStr);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            request.setAttribute("errore", "Devi essere loggato per poter acquistare");
            response.sendRedirect("userServlet");
            return;
        }

        Utente utente = (Utente) session.getAttribute("utente");

        MetodoPagamentoDAO metodoPagamentoDAO = new MetodoPagamentoDAO();
        List<MetodoPagamento> metodiPagamento = new ArrayList<>();

        try {
            metodiPagamento = metodoPagamentoDAO.doRetrievebyUtente(utente);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        CarrelloDAO carrelloDAO = new CarrelloDAO();
        ContenutoCarrelloDAO contenutoCarrelloDAO = new ContenutoCarrelloDAO();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        Carrello carrello = carrelloDAO.doRetrieveByUserId(utente.getId());
        List<ContenutoCarrello> contenutiCarrello = contenutoCarrelloDAO.doRetrieveByCarrelloId(carrello.getIdCarrello());

        List<Prodotto> prodottiCarrello = new ArrayList<>();
        for (ContenutoCarrello item : contenutiCarrello) {
            Prodotto prodotto = prodottoDAO.doRetrieveById(item.getIdProdotto());
            prodottiCarrello.add(prodotto);
        }

        request.setAttribute("metodi", metodiPagamento);
        request.setAttribute("prodottiCarrello", prodottiCarrello);
        request.setAttribute("totale", totale);

        request.getRequestDispatcher("/WEB-INF/checkout.jsp").forward(request, response);
    }
}