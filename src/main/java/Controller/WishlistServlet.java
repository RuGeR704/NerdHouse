package Controller;

import Model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        List<Prodotto> prodotti = new ArrayList<>();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        if (utente != null) {
            WishlistDAO wishlistDAO = new WishlistDAO();
            int idWishlist = wishlistDAO.doRetrieveIdWishlistByUtente(utente.getId());
            prodotti = wishlistDAO.doRetrieveWishlistByUtente(utente.getId());
        } else {
            // Guest
            List<Integer> wishlistGuest = (List<Integer>) session.getAttribute("wishlistGuest");
            if (wishlistGuest != null) {
                for (Integer idProdotto : wishlistGuest) {
                    Prodotto p = prodottoDAO.doRetrieveById(idProdotto);
                    if (p != null) prodotti.add(p);
                }
            }
        }

        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/wishlist.jsp").forward(request, response);
    }
}
