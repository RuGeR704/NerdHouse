package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImmagineProdottoDAO {

    public void doSave(int idProdotto, String percorsoImmagine, int ordine, String altText) throws SQLException {
        String sql = "INSERT INTO immagine_prodotto (ID_Prodotto, Percorso_Immagine, Ordine, Alt_Text) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProdotto);
            ps.setString(2, percorsoImmagine);
            ps.setInt(3, ordine);
            ps.setString(4, altText);

            ps.executeUpdate();
        }
    }

    public List<ImmagineProdotto> doRetrieveByProdotto(int idProdotto) {
        List<ImmagineProdotto> immagini = new ArrayList<>();
        String sql = "SELECT * FROM immagine_prodotto WHERE ID_Prodotto = ? ORDER BY Ordine";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idProdotto);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ImmagineProdotto img = new ImmagineProdotto();
                img.setIdImmagine(rs.getInt("ID_Immagine"));
                img.setIdProdotto(rs.getInt("ID_Prodotto"));
                img.setPercorsoImmagine(rs.getString("Percorso_Immagine"));
                img.setOrdine(rs.getInt("Ordine"));
                img.setAltText(rs.getString("Alt_Text"));
                immagini.add(img);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero immagini del prodotto", e);
        }

        return immagini;
    }

    public ImmagineProdotto doRetrieveById(int id) {
        String sql = "SELECT * FROM immagine_prodotto WHERE ID_Immagine = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ImmagineProdotto img = new ImmagineProdotto();
                img.setIdImmagine(rs.getInt("ID_Immagine"));
                img.setIdProdotto(rs.getInt("ID_Prodotto"));
                img.setPercorsoImmagine(rs.getString("Percorso_Immagine"));
                img.setOrdine(rs.getInt("Ordine"));
                img.setAltText(rs.getString("Alt_Text"));
                return img;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero immagine", e);
        }
    }


    public boolean doDeleteById(int idImmagine) {
        String sql = "DELETE FROM immagine_prodotto WHERE ID_Immagine = ?";


        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idImmagine);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Errore nella cancellazione immagine", e);
        }
    }

    public boolean doDeleteByProdotto(int idProdotto) {
        String sql = "DELETE FROM immagine_prodotto WHERE ID_Prodotto = ?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idProdotto);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Errore nella cancellazione immagini del prodotto", e);
        }
    }
}

