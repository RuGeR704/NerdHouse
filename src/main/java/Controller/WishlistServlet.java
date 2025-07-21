package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        WishlistDAO wishlistDAO = new WishlistDAO();
        int idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
        List<Prodotto> prodotti = wishlistDAO.doRetrieveWishlistByUtente(utente.getId());

        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/jsp/AreaUtente.jsp").forward(request, response);
    }
}
