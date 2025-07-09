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
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/aggiornaUtente")
public class AggiornaUtenteServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("utente");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String indirizzo = request.getParameter("indirizzo");
        String dataNascita_str = request.getParameter("dataNascita");
        Date dataNascita = Date.valueOf(dataNascita_str);
        String telefono = request.getParameter("telefono");

        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setIndirizzo(indirizzo);
        utente.setDataNascita(dataNascita);
        utente.setTelefono(telefono);

        UtenteDAO dao = new UtenteDAO();

        try {
            dao.doUpdate(utente);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        session.setAttribute("utente", utente);
        response.sendRedirect("AreaUtente.jsp");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }
}
