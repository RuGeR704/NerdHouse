package Controller;

import Model.Utente;
import Model.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet("/aggiornaPassword")
public class AggiornaPasswordServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        Utente oldUtente = new Utente();
        Utente newUtente = new Utente();
        UtenteDAO dao = new UtenteDAO();

        String oldPassword = request.getParameter("old-pass");
        String newPassword = request.getParameter("new-pass");

        oldUtente.setPassword(oldPassword);
        String hashedOldPassword = oldUtente.getPassword();

        newUtente.setPassword(newPassword);
        String hashedNewPassword = newUtente.getPassword();

        System.out.println("Pass nel form hashata" + hashedOldPassword);
        System.out.println("Pass dell'utente in sessione:" + utente.getPassword());
        System.out.println("Nuova pass hashata:" + newUtente.getPassword());

            if (utente == null) {
                response.sendRedirect("index.html");
                return;
            }

            try {
                if (hashedOldPassword.equals(utente.getPassword())) {
                    dao.doUpdatePassword(utente, hashedNewPassword);
                    request.setAttribute("esito", "Password aggiornata con successo!");
                    request.getRequestDispatcher("/WEB-INF/AreaUtente.jsp").forward(request, response);
                } else {
                    request.setAttribute("esito", "Password attuale non corretta, riprova!");
                    request.getRequestDispatcher("/WEB-INF/AreaUtente.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }
}
