package Controller;

import Model.ImmagineProdotto;
import Model.ImmagineProdottoDAO;
import Model.Prodotto;
import Model.ProdottoDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet(name="ModificaProdotto", value="/modificaProdotto")
@MultipartConfig
public class ModificaProdottoServlet extends HttpServlet {

    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd")
                .create();
    }

    private static class ProdottoConImmagini {
        Prodotto prodotto;
        List<ImmagineProdotto> immagini;
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
                ImmagineProdottoDAO immagineDAO = new ImmagineProdottoDAO();
                List<ImmagineProdotto> immagini = immagineDAO.doRetrieveByProdotto(id);

                Map<String, Object> data = new HashMap<>();
                data.put("prodotto", p);
                data.put("immagini", immagini);

                out.print(gson.toJson(data));
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
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("in POST");

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
            int idCategoria = Integer.parseInt(request.getParameter("categoriaId"));  // <-- aggiunto

            ProdottoDAO dao = new ProdottoDAO();
            ImmagineProdottoDAO immagineDAO = new ImmagineProdottoDAO();

            String immaginiDaRimuovereStr = request.getParameter("immaginiDaRimuovere");
            System.out.println("Immagini recuperate");
            if (immaginiDaRimuovereStr != null && !immaginiDaRimuovereStr.isEmpty()) {
                String[] idsDaRimuovere = immaginiDaRimuovereStr.split(",");
                for (String idStr : idsDaRimuovere) {
                    System.out.println("nel for");
                    int idImmagine = Integer.parseInt(idStr);

                    ImmagineProdotto img = immagineDAO.doRetrieveById(idImmagine);
                    if (img != null) {
                        System.out.println("If superato");
                        String pathAssoluto = getServletContext().getRealPath(img.getPercorsoImmagine());
                        File file = new File(pathAssoluto);
                        if (file.exists()) {
                            file.delete();
                        }
                        System.out.println("Immagine eliminata in locale");
                        immagineDAO.doDeleteById(idImmagine);
                        System.out.println("Immagine eliminata in db");
                    }
                }
            }

            String uploadPath = getServletContext().getRealPath("") + File.separator + "images/products";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            for (Part part : request.getParts()) {
                if ("nuoveImmagini".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
                    String filePath = uploadPath + File.separator + uniqueFileName;

                    try (InputStream input = part.getInputStream()) {
                        Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                    }

                    String percorsoRelativo = "/images/products/" + uniqueFileName;

                    // >>> MODIFICA 2: Chiama `doSave` con i parametri singoli
                    // Per Ordine e Alt_Text usiamo valori di default, vedi consigli sotto.
                    immagineDAO.doSave(id, percorsoRelativo, 0, "");
                }
            }


            Prodotto p = new Prodotto();
            p.setId_prodotto(id);
            p.setTitolo(titolo);
            p.setDescrizione(descrizione);
            p.setPrezzo(prezzo);
            p.setAutore(autore);
            p.setDataUscita(dataUscita);
            p.setLingua(lingua);
            p.setEditore(editore);
            p.setId_categoria(idCategoria);  // <-- aggiunto

            dao.doUpdate(p);

            getServletContext().setAttribute("prodotti", dao.doRetrieveAll());
            response.sendRedirect(request.getContextPath() + "/shop.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Errore durante la modifica del prodotto");
        }
    }
}
