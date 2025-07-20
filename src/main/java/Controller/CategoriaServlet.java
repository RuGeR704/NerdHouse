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

        String categoriaParam = request.getParameter("categoria");
        if (categoriaParam == null || categoriaParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Categoria mancante");
            return;
        }

        CategoriaDAO categoriaDAO = new CategoriaDAO();
        Categoria categoria = categoriaDAO.doRetrieveByNome(categoriaParam);
        if (categoria == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Categoria non valida");
            return;
        }

        int idCategoria = categoria.getIdCategoria();
        request.setAttribute("categoria", categoria);

        // Filtri
        String tipo = request.getParameter("tipo");
        String lingua = request.getParameter("lingua");
        String editore = request.getParameter("editore");
        String autore = request.getParameter("autore");
        String disponibilita = request.getParameter("disponibilita");
        String prezzoMinStr = request.getParameter("prezzoMin");
        String prezzoMaxStr = request.getParameter("prezzoMax");

        Double prezzoMin = (prezzoMinStr != null && !prezzoMinStr.isEmpty()) ? Double.parseDouble(prezzoMinStr) : null;
        Double prezzoMax = (prezzoMaxStr != null && !prezzoMaxStr.isEmpty()) ? Double.parseDouble(prezzoMaxStr) : null;

        ProdottoDAO prodottoDAO = new ProdottoDAO();

        List<String> tipi = categoriaDAO.doRetrieveAllTipi();
        List<String> autori = prodottoDAO.doRetrieveAllAutori(idCategoria);
        List<String> editori = prodottoDAO.doRetrieveAllEditori(idCategoria);

        List<Prodotto> prodotti = prodottoDAO.doRetrieveFiltrati(idCategoria, tipo, lingua, editore, autore, disponibilita, prezzoMin, prezzoMax);

        request.setAttribute("tipi", tipi);
        request.setAttribute("autori", autori);
        request.setAttribute("editori", editori);
        request.setAttribute("prodotti", prodotti);

        request.getRequestDispatcher("/WEB-INF/jsp/catalogoCategoria.jsp").forward(request, response);
    }
}