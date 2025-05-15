package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.SQLException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import Model.Utente;
import Model.UtenteDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "RegistrationServlet", value = "/servlet-registrazione")
public class RegistrationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String dataStr = request.getParameter("dataNascita");
        Date data = Date.valueOf(dataStr);
        String indirizzo = request.getParameter("indirizzo");
        String telefono = request.getParameter("telefono");

        Utente utente = new Utente();
        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setPassword(password);
        utente.setDataNascita(data);
        utente.setIndirizzo(indirizzo);
        utente.setTelefono(telefono);

        request.getSession().setAttribute("utente", utente);

        try {
            UtenteDAO dao = new UtenteDAO();
            dao.doSave(utente);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/RegistrationSuccess.jsp");
        view.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }
}

