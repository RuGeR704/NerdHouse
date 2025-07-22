package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContenutoCarrelloDAO {

    public void doSave(int idCarrello, int idProdotto, int quantita) {
        String sql = "INSERT INTO Contenuto_Carrello (ID_Carrello, ID_Prodotto, Quantita) VALUES (?, ?, ?)";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCarrello);
            ps.setInt(2, idProdotto);
            ps.setInt(3, quantita);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio del contenuto del carrello", e);
        }
    }

    public void doUpdate(int idCarrello, int idProdotto, int nuovaQuantita) {
        String sql = "UPDATE Contenuto_Carrello SET Quantita = ? WHERE ID_Carrello = ? AND ID_Prodotto = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, nuovaQuantita);
            ps.setInt(2, idCarrello);
            ps.setInt(3, idProdotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nell'aggiornamento del contenuto del carrello", e);
        }
    }

    public void doDelete(int idCarrello, int idProdotto) {
        String sql = "DELETE FROM Contenuto_Carrello WHERE ID_Carrello = ? AND ID_Prodotto = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCarrello);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nella rimozione del prodotto dal carrello", e);
        }
    }

    public List<ContenutoCarrello> doRetrieveByCarrelloId(int idCarrello) {
        List<ContenutoCarrello> contenuti = new ArrayList<>();
        String sql = "SELECT ID_Prodotto, Quantita FROM Contenuto_Carrello WHERE ID_Carrello = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCarrello);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ContenutoCarrello c = new ContenutoCarrello();
                    c.setIdCarrello(idCarrello);
                    c.setIdProdotto(rs.getInt("ID_Prodotto"));
                    c.setQuantita(rs.getInt("quantita"));
                    contenuti.add(c);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero del contenuto del carrello", e);
        }
        return contenuti;
    }

    public ContenutoCarrello doRetrieveByCarrelloAndProdotto(int idCarrello, int idProdotto) {
        ContenutoCarrello contenuto = null;
        String sql = "SELECT * FROM contenuto_carrello WHERE id_carrello = ? AND id_prodotto = ?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCarrello);
            ps.setInt(2, idProdotto);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    contenuto = new ContenutoCarrello();
                    contenuto.setIdCarrello(rs.getInt("id_carrello"));
                    contenuto.setIdProdotto(rs.getInt("id_prodotto"));
                    contenuto.setQuantita(rs.getInt("quantita"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contenuto;
    }

    public void doDeleteAllByCarrelloId(int idCarrello) {
        String sql = "DELETE FROM Contenuto_Carrello WHERE ID_Carrello = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCarrello);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nella cancellazione di tutti i contenuti del carrello", e);
        }
    }
}