package Controller;

import Model.MetodoPagamento;
import Model.MetodoPagamentoDAO;
import Model.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/userServlet")
public class UserAreaServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        System.out.println("In doGet");
        HttpSession session = request.getSession(false);

        System.out.println("Sessione: " + session);
        if (session != null) {
            System.out.println("Attributo 'utente': " + session.getAttribute("utente"));
        }

        System.out.println("Prima dell'if");
        if (session != null && session.getAttribute("utente") != null) {

            System.out.println("Dopo l'if");

            Utente utente = (Utente) session.getAttribute("utente");

            System.out.println("ID Utente:" + utente.getId());

            MetodoPagamentoDAO dao = new MetodoPagamentoDAO();

            List<MetodoPagamento> metodi = new ArrayList<>();

            try {
                metodi = dao.doRetrievebyUtente(utente);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            request.setAttribute("metodi", metodi);

            request.setAttribute("utente", utente);

            request.getRequestDispatcher("/WEB-INF/AreaUtente.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}


