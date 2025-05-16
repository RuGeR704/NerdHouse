package Model;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ContenutoCarrelloDAO {

    public List<Prodotto> doRetrieveProdottiByIdCarrello(int idCarrello) {
        List<Prodotto> prodotti = new ArrayList<>();

        String sql = """
            SELECT p.*
            FROM Contenuto_Carrello cc
            JOIN Prodotto p ON cc.ID_Prodotto = p.ID_Prodotto
            WHERE cc.ID_Carrello = ?
        """;

        try (Connection conn = ConPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idCarrello);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Prodotto prodotto = new Prodotto();
                    prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                    prodotto.setTitolo(rs.getString("Titolo"));
                    prodotto.setPrezzo(rs.getDouble("Prezzo"));
                    prodotto.setLingua(rs.getString("Lingua"));
                    prodotto.setAutore(rs.getString("Autore"));
                    prodotto.setDataUscita(rs.getDate("Data_Uscita").toLocalDate());
                    prodotto.setDescrizione(rs.getString("Descrizione"));
                    prodotto.setEditore(rs.getString("Editore"));
                    prodotto.setDisponibilità(rs.getBoolean("Disponibilita"));
                    prodotto.setId_categoria(rs.getInt("ID_Categoria"));

                    prodotti.add(prodotto);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Usa un logger in ambienti reali
        }

        return prodotti;
    }
}