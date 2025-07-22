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

        CategoriaDAO categoriaDAO = new CategoriaDAO();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        String idCategoriaParam = request.getParameter("categoria");
        Integer idCategoria = null;
        Categoria categoria = null;


        if (idCategoriaParam != null && !idCategoriaParam.isEmpty()) {
            try {
                idCategoria = Integer.parseInt(idCategoriaParam);
                categoria = categoriaDAO.doRetrieveByID(idCategoria);
                if (categoria == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Categoria non valida");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Categoria non valida");
                return;
            }
        }

        // Recupera filtri facoltativi
        String tipo = request.getParameter("tipo");
        String lingua = request.getParameter("lingua");
        String editore = request.getParameter("editore");
        String autore = request.getParameter("autore");
        String disponibilita = request.getParameter("disponibilita");
        String prezzoMinStr = request.getParameter("prezzoMin");
        String prezzoMaxStr = request.getParameter("prezzoMax");

        Double prezzoMin = (prezzoMinStr != null && !prezzoMinStr.isEmpty()) ? Double.parseDouble(prezzoMinStr) : null;
        Double prezzoMax = (prezzoMaxStr != null && !prezzoMaxStr.isEmpty()) ? Double.parseDouble(prezzoMaxStr) : null;

        List<Prodotto> prodotti = prodottoDAO.doRetrieveFiltrati(idCategoria, tipo, lingua, editore, autore, disponibilita, prezzoMin, prezzoMax);
        List<Categoria> categorie = categoriaDAO.doRetrieveAll();
        List<String> tipi = categoriaDAO.doRetrieveAllTipi();

        List<String> autori;
        List<String> editori;

        if (prodotti.isEmpty()) {
            // Nessun prodotto trovato per la categoria: mostra autori/editori globali senza filtro categoria
            autori = prodottoDAO.doRetrieveAllAutori(null);
            editori = prodottoDAO.doRetrieveAllEditori(null);
        } else {
            // Prodotti trovati: filtra autori/editori per categoria
            autori = prodottoDAO.doRetrieveAllAutori(idCategoria);
            editori = prodottoDAO.doRetrieveAllEditori(idCategoria);
        }

        request.setAttribute("prodotti", prodotti);
        request.setAttribute("categorie", categorie);
        request.setAttribute("tipi", tipi);
        request.setAttribute("autori", autori);
        request.setAttribute("editori", editori);
        request.setAttribute("categoria", categoria);

        request.getRequestDispatcher("/shop.jsp").forward(request, response);
    }
}