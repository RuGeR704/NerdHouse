package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO per recuperare gli ordini di un utente con i dettagli del prodotto (titolo).
 * Utilizza una JOIN tra Ordine e Prodotto.
 */
public class OrdineDAO {

    /**
     * Recupera gli ordini effettuati da un determinato utente,
     * arricchiti con il titolo del prodotto (da tabella Prodotto).
     *
     * @param idUtente ID dell'utente di cui recuperare gli ordini
     * @return lista di oggetti OrdineDettaglio
     */
    public List<OrdineDettaglio> doRetrieveByUtenteId(int idUtente) {
        List<OrdineDettaglio> ordini = new ArrayList<>();

        String sql = """
            SELECT o.ID_Prodotto, p.Titolo, o.Pagamento, o.Indirizzo_Ordine,
                   o.Stato, o.Data_Ordine
            FROM Ordine o
            JOIN Prodotto p ON o.ID_Prodotto = p.ID_Prodotto
            WHERE o.ID_Utente = ?
            ORDER BY o.Data_Ordine DESC
        """;

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineDettaglio od = new OrdineDettaglio();
                    od.setIdProdotto(rs.getInt("ID_Prodotto"));
                    od.setTitoloProdotto(rs.getString("Titolo"));
                    od.setPagamento(rs.getString("Pagamento"));
                    od.setIndirizzoOrdine(rs.getString("Indirizzo_Ordine"));
                    od.setStato(rs.getString("Stato"));
                    od.setDataOrdine(rs.getTimestamp("Data_Ordine"));
                    ordini.add(od);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero degli ordini utente", e);
        }

        return ordini;
    }

    public int doSave(Ordine ordine) {
        String sql = "INSERT INTO Ordine (ID_Utente, Pagamento, Indirizzo_Ordine, Stato, Data_Ordine) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, ordine.getIdUtente());
            ps.setString(2, ordine.getPagamento());
            ps.setString(3, ordine.getIndirizzoOrdine());
            ps.setString(4, ordine.getStato());
            ps.setTimestamp(5, ordine.getDataOrdine());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);  // restituisce l'ID_Ordine appena generato
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Errore salvataggio ordine", e);
        }
        return -1;
    }
}