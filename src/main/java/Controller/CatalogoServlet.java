package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> prodotti = dao.doRetrieveAll();
        request.setAttribute("prodotti", prodotti);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/catalogo.jsp");
        dispatcher.forward(request, response);
    }
}