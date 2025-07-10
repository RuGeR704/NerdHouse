package Controller;

import Model.Prodotto;
import Model.ProdottoDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dettaglioProdotto")
public class ProdottoDettaglioServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idProdottoParam = request.getParameter("idProdotto");

        if (idProdottoParam == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        try {
            int idProdotto = Integer.parseInt(idProdottoParam);
            Prodotto prodotto = new ProdottoDAO().doRetrieveById(idProdotto);

            if (prodotto == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            request.setAttribute("prodotto", prodotto);
            request.getRequestDispatcher("dettaglioProdotto.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
        }
    }
}
