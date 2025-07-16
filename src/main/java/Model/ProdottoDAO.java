package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

    public Prodotto doRetrieveById(int id) {

        try(Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM PRODOTTO WHERE ID_Prodotto = ?";
            PreparedStatement ps = con.prepareStatement(query);

            //Imposta ID Prodotto
            ps.setInt(1, id);

            //Creazione prodotto dal database
            ResultSet rs = ps.executeQuery();
            rs.next();

            Prodotto prodotto = new Prodotto();
            prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
            prodotto.setTitolo(rs.getString("Titolo"));
            prodotto.setDescrizione(rs.getString("Descrizione"));
            prodotto.setPrezzo(rs.getFloat("Prezzo"));
            prodotto.setAutore(rs.getString("Autore"));
            prodotto.setDataUscita(rs.getDate("DataUscita"));
            prodotto.setEditore(rs.getString("Editore"));
            prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
            prodotto.setLingua(rs.getString("Lingua"));
            prodotto.setId_categoria(rs.getInt("Id_categoria"));

            return prodotto;

        } catch (SQLException e) {
            throw new RuntimeException();
        }
    }

    public List<Prodotto> doRetrieveAll() {

        try(Connection con = ConPool.getConnection()) {
            String query = "SELECT Titolo, Prezzo, Descrizione, Lingua, Prezzo, Data_Uscita, Editore, Disponibilità, ID_Categoria  FROM PRODOTTO";
            ResultSet rs = con.prepareStatement(query).executeQuery();

            List<Prodotto> prodotti = new ArrayList<Prodotto>();

            //Creazione lista prodotti
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setPrezzo(rs.getFloat("Prezzo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setPrezzo(rs.getFloat("Prezzo"));
                prodotto.setDataUscita(rs.getDate("DataUscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setId_categoria(rs.getInt("Id_categoria"));
                prodotti.add(prodotto);
            }

            return prodotti;

        } catch (SQLException e){
            throw new RuntimeException();
        }
    }

    public List<Prodotto> doRetrieveByCategoria(int idCategoria, String lingua, String editore) {
        List<Prodotto> prodotti = new ArrayList<>();

        try (Connection con = ConPool.getConnection()) {
            StringBuilder query = new StringBuilder("SELECT * FROM PRODOTTO WHERE Id_categoria = ?");

            // Costruzione dinamica della query
            if (lingua != null && !lingua.isEmpty()) {
                query.append(" AND Lingua = ?");
            }
            if (editore != null && !editore.isEmpty()) {
                query.append(" AND Editore = ?");
            }

            PreparedStatement ps = con.prepareStatement(query.toString());

            int index = 1;
            ps.setInt(index++, idCategoria);
            if (lingua != null && !lingua.isEmpty()) {
                ps.setString(index++, lingua);
            }
            if (editore != null && !editore.isEmpty()) {
                ps.setString(index++, editore);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setPrezzo(rs.getFloat("Prezzo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("DataUscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
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
            String sql = "SELECT * FROM Prodotto WHERE Titolo LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + titolo + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setPrezzo(rs.getFloat("Prezzo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setId_categoria(rs.getInt("ID_Categoria"));

                prodotti.add(prodotto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return prodotti;
    }
}
