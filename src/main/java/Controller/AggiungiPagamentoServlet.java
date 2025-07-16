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

@WebServlet("/aggiungiPagamento")
public class AggiungiPagamentoServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String numeroCarta = request.getParameter("numeroCarta");
        String nomeIntestatario = request.getParameter("nomeIntestatario");
        String scadenza = request.getParameter("scadenza");

        if (numeroCarta == null || numeroCarta.length() < 13) {
            request.setAttribute("errore", "Numero carta non valido");
            request.getRequestDispatcher("/WEB-INF/AreaUtente.jsp").forward(request, response);
            return;
        }

        // Riconoscimento tipo carta
        char firstDigit = numeroCarta.charAt(0);
        String tipoMetodo;
        switch (firstDigit) {
            case '4':
                tipoMetodo = "VISA";
                break;
            case '5':
                tipoMetodo = "MasterCard";
                break;
            case '3':
                tipoMetodo = "American Express";
                break;
            case '6':
                tipoMetodo = "Discover";
                break;
            default:
                tipoMetodo = "Altro";
                break;
        }

        // Ultime 4 cifre della carta
        String ultime4 = numeroCarta.substring(numeroCarta.length() - 4);

        // Salva nel DB
        MetodoPagamento metodo = new MetodoPagamento();
        metodo.setId_utente(utente.getId());
        metodo.setTipoMetodo(tipoMetodo);
        metodo.setNumeriFinaliCarta(ultime4);
        metodo.setNomeIntestatario(nomeIntestatario);
        metodo.setScadenza(scadenza);
        metodo.setAttivo(true);

        MetodoPagamentoDAO dao = new MetodoPagamentoDAO();

        try {
            dao.doSave(metodo);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/userServlet");

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }
}
