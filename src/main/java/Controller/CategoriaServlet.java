package Controller;

import Model.Categoria;
import Model.CategoriaDAO;
import Model.Prodotto;
import Model.ProdottoDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/categoria")
public class CategoriaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idCategoria = Integer.parseInt(request.getParameter("id"));
        String lingua = request.getParameter("lingua");
        String editore = request.getParameter("editore");

        // Recupera la categoria per il nome da visualizzare
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        Categoria categoria = categoriaDAO.doRetrieveByID(idCategoria);
        request.setAttribute("nomeCategoria", categoria.getNome());
        request.setAttribute("categoria", categoria);

        // Recupera i prodotti filtrati già con la query SQL
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodotti = prodottoDAO.doRetrieveByCategoria(idCategoria, lingua, editore);

        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/jsp/catalogoCategoria.jsp").forward(request, response);
    }
}