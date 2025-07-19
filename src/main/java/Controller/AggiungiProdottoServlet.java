package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/aggiungiProdotto")
public class AggiungiProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String titolo = request.getParameter("titolo");
        String descrizione = request.getParameter("descrizione");
        String lingua = request.getParameter("lingua");
        String autore = request.getParameter("autore");
        String dataStr = request.getParameter("dataUscita");
        Date data = Date.valueOf(dataStr);
        String editore = request.getParameter("editore");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));

        Prodotto p = new Prodotto();
        p.setTitolo(titolo);
        p.setDescrizione(descrizione);
        p.setLingua(lingua);
        p.setAutore(autore);
        p.setDataUscita(data);
        p.setEditore(editore);
        p.setPrezzo(prezzo);

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        prodottoDAO.doSave(p);

        List<Prodotto> prodottiAggiornati = prodottoDAO.doRetrieveAll();

        request.setAttribute("prodotti", prodottiAggiornati);

        request.getRequestDispatcher("/shop.jsp").forward(request, response);
    }
}
