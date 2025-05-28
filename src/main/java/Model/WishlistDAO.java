package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public void doCreateWishlist(int idUtente) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Wishlist (ID_Utente, Data_Aggiunta) VALUES (?, CURRENT_DATE)"
            );
            ps.setInt(1, idUtente);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doAddToWishlist(int idWishlist, int idProdotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT IGNORE INTO Contenuto_Wishlist (ID_Wishlist, ID_Prodotto) VALUES (?, ?)"
            );
            ps.setInt(1, idWishlist);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doRemoveFromWishlist(int idWishlist, int idProdotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM Contenuto_Wishlist WHERE ID_Wishlist = ? AND ID_Prodotto = ?"
            );
            ps.setInt(1, idWishlist);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveWishlistByUtente(int idUtente) {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT p.* FROM Prodotto p " +
                            "JOIN Contenuto_Wishlist cw ON p.ID_Prodotto = cw.ID_Prodotto " +
                            "JOIN Wishlist w ON cw.ID_Wishlist = w.ID_Wishlist " +
                            "WHERE w.ID_Utente = ?"
            );
            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId_prodotto(rs.getInt("ID_Prodotto"));
                p.setTitolo(rs.getString("Titolo"));
                p.setPrezzo(rs.getBigDecimal("Prezzo").doubleValue());
                p.setLingua(rs.getString("Lingua"));
                p.setAutore(rs.getString("Autore"));
                p.setDataUscita(rs.getDate("Data_Uscita"));
                p.setDescrizione(rs.getString("Descrizione"));
                p.setEditore(rs.getString("Editore"));
                p.setDisponibilita(rs.getBoolean("Disponibilita"));
                p.setId_categoria(rs.getInt("ID_Categoria"));
                prodotti.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return prodotti;
    }

    public int doRetrieveIdWishlistByUtente(int idUtente) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT ID_Wishlist FROM Wishlist WHERE ID_Utente = ?"
            );
            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("ID_Wishlist");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return -1; // Non trovata
    }
}
