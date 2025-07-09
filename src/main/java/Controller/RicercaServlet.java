package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/ricerca")
public class RicercaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");

        if (query == null || query.trim().isEmpty()) {
            request.setAttribute("errore", "Nessun termine inserito per la ricerca.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> risultati = prodottoDAO.doRetrieveByTitolo(query);

        request.setAttribute("risultati", risultati);
        request.setAttribute("query", query);
        request.getRequestDispatcher("risultatiRicerca.jsp").forward(request, response);
    }
}