package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

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
                prodotto.setDataUscita(rs.getDate("DataUscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotto.setImmagine(rs.getString("Immagine")); //
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
                prodotto.setDataUscita(rs.getDate("DataUscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotto.setImmagine(rs.getString("Immagine")); //
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
                prodotto.setDataUscita(rs.getDate("DataUscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotto.setImmagine(rs.getString("Immagine"));
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
                prodotto.setDataUscita(rs.getDate("DataUscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotto.setImmagine(rs.getString("Immagine"));
                prodotti.add(prodotto);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
