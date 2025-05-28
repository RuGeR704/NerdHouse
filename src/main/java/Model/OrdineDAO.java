package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {

    public void doSave(Ordine ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Ordine (ID_Utente, ID_Prodotto, Pagamento, Indirizzo_Ordine, Stato, Data_Ordine) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setInt(1, ordine.getIdUtente());
            ps.setInt(2, ordine.getIdProdotto());
            ps.setString(3, ordine.getPagamento());
            ps.setString(4, ordine.getIndirizzoOrdine());
            ps.setString(5, ordine.getStato());
            ps.setTimestamp(6, ordine.getDataOrdine());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Ordine> doRetrieveByUtenteId(int idUtente) {
        List<Ordine> ordini = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Ordine WHERE ID_Utente = ? ORDER BY Data_Ordine DESC"
            );
            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdUtente(rs.getInt("ID_Utente"));
                o.setIdProdotto(rs.getInt("ID_Prodotto"));
                o.setPagamento(rs.getString("Pagamento"));
                o.setIndirizzoOrdine(rs.getString("Indirizzo_Ordine"));
                o.setStato(rs.getString("Stato"));
                o.setDataOrdine(rs.getTimestamp("Data_Ordine"));
                ordini.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ordini;
    }

    public void doDelete(int idUtente, int idProdotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM Ordine WHERE ID_Utente = ? AND ID_Prodotto = ?"
            );
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}