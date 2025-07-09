package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/rimuoviWishlist")
public class RimuoviWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        Utente utente = (Utente) request.getSession().getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        WishlistDAO wishlistDAO = new WishlistDAO();
        int idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());

        if (idWishlist != -1) {
            wishlistDAO.doRemoveFromWishlist(idWishlist, idProdotto);
        }

        response.sendRedirect("wishlist");
    }
}