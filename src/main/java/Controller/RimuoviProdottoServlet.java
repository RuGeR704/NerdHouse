package Controller;

import Model.ProdottoDAO;
import Model.Prodotto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rimuoviProdotto")
public class RimuoviProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idProdotto");

        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                ProdottoDAO dao = new ProdottoDAO();
                dao.doDelete(id);

                List<Prodotto> listaAggiornata = dao.doRetrieveAll();
                getServletContext().setAttribute("prodotti", listaAggiornata);

            } catch (NumberFormatException e) {
                e.printStackTrace();
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/shop.jsp");
    }
}

