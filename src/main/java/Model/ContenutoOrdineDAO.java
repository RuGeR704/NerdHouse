package Model;

import java.sql.*;

public class ContenutoOrdineDAO {

    public void doSave(ContenutoOrdine contenuto) {
        String sql = "INSERT INTO Contenuto_Ordine (ID_Ordine, ID_Prodotto, Quantita) VALUES (?, ?, ?)";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, contenuto.getIdOrdine());
            ps.setInt(2, contenuto.getIdProdotto());
            ps.setInt(3, contenuto.getQuantita());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio del contenuto dell'ordine", e);
        }
    }
}