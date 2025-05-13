package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "RegistrationServlet", value = "/servlet-registrazione")
public class RegistrationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String id = request.getParameter("id");
        String telefono = request.getParameter("telefono");


        response.setContentType("text/html;charset=UTF-8");


        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h2>Dati ricevuti:</h2>");
        out.println("<p>Nome: " + nome + "</p>");
        out.println("<p>Cognome: " + cognome + "</p>");
        out.println("<p>Email: " + email + "</p>");
        out.println("<p>Password: " + password + "</p>");
        out.println("<p>ID: " + id + "</p>");
        out.println("<p>Telefono: " + telefono + "</p>");
        out.println("</body></html>");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }
}

