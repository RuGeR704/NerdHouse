package Controller;

import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/aggiungiWishlist")
public class AggiungiWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        Utente utente = (Utente) request.getSession().getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        WishlistDAO wishlistDAO = new WishlistDAO();
        int idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());

        if (idWishlist == -1) {
            wishlistDAO.doCreateWishlist(utente.getId());
            idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
        }

        wishlistDAO.doAddToWishlist(idWishlist, idProdotto);
        response.sendRedirect("catalogo");
    }
}
