package Controller;

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

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodotti = prodottoDAO.doRetrievebyCategoria(idCategoria);

        // Filtraggio base lato Java (opzionale: puoi spostarlo in query SQL per efficienza)
        if (lingua != null && !lingua.isEmpty()) {
            prodotti.removeIf(p -> !p.getLingua().equalsIgnoreCase(lingua));
        }
        if (editore != null && !editore.isEmpty()) {
            prodotti.removeIf(p -> !p.getEditore().equalsIgnoreCase(editore));
        }

        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/jsp/catalogoCategoria.jsp").forward(request, response);
    }
}
