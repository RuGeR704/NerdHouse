package Controller;

import Model.Categoria;
import Model.CategoriaDAO;
import Model.Prodotto;
import Model.ProdottoDAO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/novita")
public class NovitàServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> novita = prodottoDAO.doRetrieveUltimi(3);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = new Gson().toJson(novita);
        response.getWriter().write(json);
    }
}
