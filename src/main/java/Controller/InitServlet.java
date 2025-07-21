package Controller;

import Model.Categoria;
import Model.CategoriaDAO;
import Model.Prodotto;
import Model.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.util.List;

@WebServlet(name = "InitServlet", urlPatterns = {}, loadOnStartup = 1)
public class InitServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        try {
            System.out.println("Avvio servlet init...");
            List<Prodotto> prodotti = new ProdottoDAO().doRetrieveAll();
            getServletContext().setAttribute("prodotti", prodotti);
            System.out.println("prodotti caricati");

            CategoriaDAO categoriaDAO = new CategoriaDAO();
            List<Categoria> categorie = categoriaDAO.doRetrieveAll();
            getServletContext().setAttribute("categorie", categorie);
            System.out.println("CATEGORIE caricate");
        } catch (Exception e) {
            throw new ServletException("Errore durante l'inizializzazione dei prodotti", e);
        }
    }
}
