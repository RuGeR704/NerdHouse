package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchAjax")
public class SearchAjaxServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String titolo = request.getParameter("titolo");
        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> risultati = dao.doRetrieveByTitolo(titolo);

        // Manda i dati in JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Usa una libreria JSON (es. Gson)
        Gson gson = new Gson();
        String json = gson.toJson(risultati);

        response.getWriter().write(json);
    }
}
