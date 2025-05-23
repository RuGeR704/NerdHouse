package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContenutoWishlistDAO {

    public List<Prodotto> doRetrieveProdottiByIdWishList(int idWishlist) {
        List<Prodotto> prodotti = new ArrayList<>();

        String sql = """
            SELECT p.*
            FROM Contenuto_Wishlist cw
            JOIN Prodotto p ON cw.ID_Prodotto = p.ID_Prodotto
            WHERE cw.ID_Wishlist = ?
        """;

        try (Connection conn = ConPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idWishlist);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Prodotto prodotto = new Prodotto();
                    prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                    prodotto.setTitolo(rs.getString("Titolo"));
                    prodotto.setPrezzo(rs.getDouble("Prezzo"));
                    prodotto.setLingua(rs.getString("Lingua"));
                    prodotto.setAutore(rs.getString("Autore"));
                    prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                    prodotto.setDescrizione(rs.getString("Descrizione"));
                    prodotto.setEditore(rs.getString("Editore"));
                    prodotto.setDisponibilità(rs.getBoolean("Disponibilita"));
                    prodotto.setId_categoria(rs.getInt("ID_Categoria"));

                    prodotti.add(prodotto);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // In produzione usa logging!
        }

        return prodotti;
    }
}
