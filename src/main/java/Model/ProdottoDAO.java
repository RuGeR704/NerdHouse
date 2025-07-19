package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {


    public void doSave(Prodotto prodotto) {
        String sql = "INSERT INTO prodotto (titolo, descrizione, prezzo, autore, data_Uscita, lingua, editore) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, prodotto.getTitolo());
            ps.setString(2, prodotto.getDescrizione());
            ps.setDouble(3, prodotto.getPrezzo());
            ps.setString(4, prodotto.getAutore());
            ps.setDate(5, prodotto.getDataUscita());
            ps.setString(6, prodotto.getLingua());
            ps.setString(7, prodotto.getEditore());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore durante il salvataggio del prodotto", e);
        }
    }

    public void doUpdate(Prodotto p) throws SQLException {
        String sql = "UPDATE prodotto SET Titolo=?, Descrizione=?, Prezzo=?, Autore=?, Data_Uscita=?, Lingua=?, Editore=? WHERE ID_Prodotto=?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getTitolo());
            ps.setString(2, p.getDescrizione());
            ps.setDouble(3, p.getPrezzo());
            ps.setString(4, p.getAutore());
            if (p.getDataUscita() != null) {
                ps.setDate(5, p.getDataUscita());
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }
            ps.setString(6, p.getLingua());
            ps.setString(7, p.getEditore());
            ps.setInt(8, p.getId_prodotto());

            ps.executeUpdate();
        }
    }

    public Prodotto doRetrieveById(int id) {
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM PRODOTTO WHERE ID_Prodotto = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzo(rs.getDouble("Prezzo"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                return prodotto;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM PRODOTTO";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            List<Prodotto> prodotti = new ArrayList<>();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzo(rs.getDouble("Prezzo"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotti.add(prodotto);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveByCategoria(int idCategoria, String lingua, String editore) {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            StringBuilder query = new StringBuilder("SELECT * FROM PRODOTTO WHERE Id_categoria = ?");
            if (lingua != null && !lingua.isEmpty()) query.append(" AND Lingua = ?");
            if (editore != null && !editore.isEmpty()) query.append(" AND Editore = ?");
            PreparedStatement ps = con.prepareStatement(query.toString());

            int index = 1;
            ps.setInt(index++, idCategoria);
            if (lingua != null && !lingua.isEmpty()) ps.setString(index++, lingua);
            if (editore != null && !editore.isEmpty()) ps.setString(index++, editore);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzo(rs.getDouble("Prezzo"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotti.add(prodotto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return prodotti;
    }

    public List<Prodotto> doRetrieveByTitolo(String titolo) {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM PRODOTTO WHERE Titolo LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + titolo + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzo(rs.getDouble("Prezzo"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotti.add(prodotto);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doDelete(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto WHERE id_prodotto = ?");
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante l'eliminazione del prodotto", e);
        }
    }
}
