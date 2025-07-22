package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;
import Model.Categoria;
import Model.CategoriaDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO dao = new ProdottoDAO();
        CategoriaDAO cdao = new CategoriaDAO();

        List<Prodotto> prodotti = dao.doRetrieveAll();
        List<Categoria> categorie = cdao.doRetrieveAll();

        request.setAttribute("prodotti", prodotti);
        request.setAttribute("categorie", categorie);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/shop.jsp");
        dispatcher.forward(request, response);//
    }
}