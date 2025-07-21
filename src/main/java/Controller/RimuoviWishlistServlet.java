package Controller;

import Model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rimuoviWishlist")
public class RimuoviWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente != null) {
            WishlistDAO wishlistDAO = new WishlistDAO();
            int idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
            if (idWishlist != -1) wishlistDAO.doRemoveFromWishlist(idWishlist, idProdotto);
        } else {
            List<Integer> wishlist = (List<Integer>) session.getAttribute("wishlistGuest");
            if (wishlist != null) {
                wishlist.removeIf(id -> id == idProdotto);
                session.setAttribute("wishlistGuest", wishlist);
            }
        }

        response.sendRedirect("wishlist");
    }
}