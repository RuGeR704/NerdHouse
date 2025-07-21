package Controller;

import Model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/aggiungiWishlist")
public class AggiungiWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente != null) {
            WishlistDAO wishlistDAO = new WishlistDAO();
            int idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
            if (idWishlist == -1) {
                wishlistDAO.doCreateWishlist(utente.getId());
                idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
            }
            wishlistDAO.doAddToWishlist(idWishlist, idProdotto);
        } else {
            // Guest
            List<Integer> wishlist = (List<Integer>) session.getAttribute("wishlistGuest");
            if (wishlist == null) wishlist = new ArrayList<>();
            if (!wishlist.contains(idProdotto)) wishlist.add(idProdotto);
            session.setAttribute("wishlistGuest", wishlist);
        }

        response.sendRedirect("wishlist");
    }
}
