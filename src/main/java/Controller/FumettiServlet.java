package Controller;

import Model.Categoria;
import Model.CategoriaDAO;
import Model.Prodotto;
import Model.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/fumetti")
public class FumettiServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // Recupera i prodotti della categoria "Fumetti"
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        CategoriaDAO categoriaDAO = new CategoriaDAO();

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

        List<Categoria> categorie = categoriaDAO.doRetrievebyNome("Fumetti");
        List<Prodotto> prodotti = new ArrayList();

        for (Categoria cat : categorie) {
            List<Prodotto> prodottiPerCategoria = prodottoDAO.doRetrieveFiltrati(cat.getIdCategoria(), tipo, lingua, editore, autore, disponibilita, prezzoMin, prezzoMax);
            prodotti.addAll(prodottiPerCategoria);
        }

        List<String> tipi = categoriaDAO.doRetrieveAllTipi();

        List<String> autori;
        List<String> editori;

        if (prodotti.isEmpty()) {
            // Nessun prodotto trovato per la categoria: mostra autori/editori globali senza filtro categoria
            autori = prodottoDAO.doRetrieveAllAutori(null);
            editori = prodottoDAO.doRetrieveAllEditori(null);
        } else {
            // Prodotti trovati: filtra autori/editori per categoria
            autori = prodottoDAO.doRetrieveAllAutori(null);
            editori = prodottoDAO.doRetrieveAllEditori(null);
        }

        request.setAttribute("prodotti", prodotti);
        request.setAttribute("categorie", categorie);
        request.setAttribute("tipi", tipi);
        request.setAttribute("autori", autori);
        request.setAttribute("editori", editori);

        request.getRequestDispatcher("/WEB-INF/fumetti.jsp").forward(request, response);
    }
}

