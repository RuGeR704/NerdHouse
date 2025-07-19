package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

@WebServlet(name="ModificaProdotto", value="/modificaProdotto")
public class ModificaProdottoServlet extends HttpServlet {

    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd")
                .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProdottoDAO dao = new ProdottoDAO();
            Prodotto p = dao.doRetrieveById(id);

            if (p != null) {
                out.print(gson.toJson(p));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Prodotto non trovato.");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID prodotto non valido.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore durante il recupero dei dati del prodotto.");
        } finally {
            out.flush();
            out.close();
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("idProdotto"));
            String titolo = request.getParameter("titolo");
            String descrizione = request.getParameter("descrizione");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            String autore = request.getParameter("autore");
            String dataStr = request.getParameter("dataUscita");
            Date dataUscita = (dataStr != null && !dataStr.isEmpty())
                    ? Date.valueOf(dataStr)
                    : null;
            String lingua = request.getParameter("lingua");
            String editore = request.getParameter("editore");

            Prodotto p = new Prodotto();
            p.setId_prodotto(id);
            p.setTitolo(titolo);
            p.setDescrizione(descrizione);
            p.setPrezzo(prezzo);
            p.setAutore(autore);
            p.setDataUscita(dataUscita);
            p.setLingua(lingua);
            p.setEditore(editore);

            ProdottoDAO dao = new ProdottoDAO();
            dao.doUpdate(p);

            getServletContext().setAttribute("prodotti", dao.doRetrieveAll());

            response.sendRedirect(request.getContextPath() + "/shop.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Errore durante la modifica del prodotto");
        }
    }
}
