package Controller;

import Model.MetodoPagamentoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/rimuoviMetodoPagamento")
public class RimuoviPagamentoServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String idMetodoStr = request.getParameter("idMetodo");

        if (idMetodoStr != null) {
            int idMetodo = Integer.parseInt(idMetodoStr);
            MetodoPagamentoDAO dao = new MetodoPagamentoDAO();
            try {
                dao.doDelete(idMetodo);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("userServlet");
    }
}
