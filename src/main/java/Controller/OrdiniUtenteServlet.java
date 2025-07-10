package Controller;

import Model.OrdineDAO;
import Model.OrdineDettaglio;
import Model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/ordiniUtente")
public class OrdiniUtenteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("user");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrdineDAO ordineDAO = new OrdineDAO();
        List<OrdineDettaglio> ordini = ordineDAO.doRetrieveByUtenteId(utente.getId());

        request.setAttribute("ordini", ordini);
        request.getRequestDispatcher("/WEB-INF/jsp/ordini.jsp").forward(request, response);
    }
}