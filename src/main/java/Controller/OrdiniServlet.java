package Controller;

import Model.Ordine;
import Model.OrdineDAO;
import Model.OrdineDettaglio;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/ordini")
public class OrdiniServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idUtente = ((Model.Utente) session.getAttribute("user")).getId();
        List<OrdineDettaglio> ordini = new OrdineDAO().doRetrieveByUtenteId(idUtente);
        request.setAttribute("ordini", ordini);
        request.setAttribute("ordini", ordini);
        request.getRequestDispatcher("/WEB-INF/jsp/ordini.jsp").forward(request, response);
    }
}