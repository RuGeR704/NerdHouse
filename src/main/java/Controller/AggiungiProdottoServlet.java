package Controller;

import Model.ImmagineProdotto;
import Model.ImmagineProdottoDAO;
import Model.Prodotto;
import Model.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

@WebServlet("/aggiungiProdotto")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
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
        int idProdotto = prodottoDAO.doSave(p);

        //immagini
        String uploadPath = getServletContext().getRealPath("/images/prodotti");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        ImmagineProdottoDAO immagineDAO = new ImmagineProdottoDAO();

        // Gestione upload immagini multiple
        Collection<Part> parts = request.getParts();
        int ordine = 1;

        for (Part part : parts) {
            if ("immagini[]".equals(part.getName()) && part.getSize() > 0) {
                // nome f
                String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                String filePath = uploadPath + File.separator + fileName;

                // salva fisicamente
                part.write(filePath);

                // percorso relativo per DB (web)
                String percorsoRelativo = "/images/prodotti/" + fileName;

                // salva dati immagine in DB
                try {
                    immagineDAO.doSave(idProdotto, percorsoRelativo, ordine, "Immagine prodotto " + ordine);
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                ordine++;
            }
        }

        List<Prodotto> prodottiAggiornati = prodottoDAO.doRetrieveAll();

        getServletContext().setAttribute("prodotti", prodottiAggiornati);

        response.sendRedirect(request.getContextPath() + "/shop.jsp");
    }
}
