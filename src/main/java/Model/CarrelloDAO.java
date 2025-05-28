package Model.DAO;

import Model.Bean.Carrello;
import Model.Connessione.ConPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarrelloDAO {
    public Carrello doRetrieveById(int idCarrello) {
        String sql = "SELECT * FROM Carrello WHERE ID_Carrello = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCarrello);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Carrello carrello = new Carrello();
                carrello.setIdCarrello(rs.getInt("ID_Carrello"));
                carrello.setIdUtente(rs.getInt("ID_Utente"));
                carrello.setQuantità(rs.getInt("Quantita"));
                carrello.setTotaleSpesa(rs.getDouble("Totale_Spesa"));
                return carrello;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recuperare il carrello", e);
        }
    }

    public Carrello doRetrieveByUserId(int idUtente) {
        String sql = "SELECT * FROM Carrello WHERE ID_Utente = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Carrello carrello = new Carrello();
                carrello.setIdCarrello(rs.getInt("ID_Carrello"));
                carrello.setIdUtente(rs.getInt("ID_Utente"));
                carrello.setQuantità(rs.getInt("Quantita"));
                carrello.setTotaleSpesa(rs.getDouble("Totale_Spesa"));
                return carrello;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recuperare il carrello per ID utente", e);
        }
    }

    public void doSave(Carrello carrello) {
        String sql = "INSERT INTO Carrello (ID_Utente, Quantita, Totale_Spesa) VALUES (?, ?, ?)";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, carrello.getIdUtente());
            ps.setInt(2, carrello.getQuantità());
            ps.setDouble(3, carrello.getTotaleSpesa());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio del carrello", e);
        }
    }

    public void doUpdate(Carrello carrello) {
        String sql = "UPDATE Carrello SET Quantita = ?, Totale_Spesa = ? WHERE ID_Carrello = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, carrello.getQuantità());
            ps.setDouble(2, carrello.getTotaleSpesa());
            ps.setInt(3, carrello.getIdCarrello());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nell'aggiornamento del carrello", e);
        }
    }

    public void doDelete(int idCarrello) {
        String sql = "DELETE FROM Carrello WHERE ID_Carrello = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCarrello);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nell'eliminazione del carrello", e);
        }
    }

    public List<Carrello> doRetrieveAll() {
        List<Carrello> carrelli = new ArrayList<>();
        String sql = "SELECT * FROM Carrello";
        try (Connection con = ConPool.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Carrello carrello = new Carrello();
                carrello.setIdCarrello(rs.getInt("ID_Carrello"));
                carrello.setIdUtente(rs.getInt("ID_Utente"));
                carrello.setQuantità(rs.getInt("Quantita"));
                carrello.setTotaleSpesa(rs.getDouble("Totale_Spesa"));
                carrelli.add(carrello);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero di tutti i carrelli", e);
        }
        return carrelli;
    }
}