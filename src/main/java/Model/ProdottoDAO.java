package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

    public int doSave(Prodotto prodotto) {
        int generatedID = -1;

        String sql = "INSERT INTO prodotto (Titolo, Descrizione, Prezzo, Autore, Data_Uscita, Lingua, Editore, Disponibilita, ID_Categoria) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, prodotto.getTitolo());
            ps.setString(2, prodotto.getDescrizione());
            ps.setDouble(3, prodotto.getPrezzo());
            ps.setString(4, prodotto.getAutore());
            if (prodotto.getDataUscita() != null) {
                ps.setDate(5, prodotto.getDataUscita());
            } else {
                ps.setNull(5, Types.DATE);
            }
            ps.setString(6, prodotto.getLingua());
            ps.setString(7, prodotto.getEditore());
            ps.setBoolean(8, prodotto.isDisponibilità());
            ps.setInt(9, prodotto.getId_categoria());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()) {
                generatedID = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore durante il salvataggio del prodotto", e);
        }

        return generatedID;
    }

    public void doUpdate(Prodotto p) throws SQLException {
        String sql = "UPDATE prodotto SET Titolo=?, Descrizione=?, Prezzo=?, Autore=?, Data_Uscita=?, Lingua=?, Editore=?, Disponibilita=?, ID_Categoria=? WHERE ID_Prodotto=?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getTitolo());
            ps.setString(2, p.getDescrizione());
            ps.setDouble(3, p.getPrezzo());
            ps.setString(4, p.getAutore());
            if (p.getDataUscita() != null) {
                ps.setDate(5, p.getDataUscita());
            } else {
                ps.setNull(5, Types.DATE);
            }
            ps.setString(6, p.getLingua());
            ps.setString(7, p.getEditore());
            ps.setBoolean(8, p.isDisponibilità());
            ps.setInt(9, p.getId_categoria());
            ps.setInt(10, p.getId_prodotto());

            ps.executeUpdate();
        }
    }

    public Prodotto doRetrieveById(int id) {
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM prodotto WHERE ID_Prodotto = ?";
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
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setId_categoria(rs.getInt("ID_Categoria"));
                return prodotto;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveByTitolo(String titolo) {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM prodotto WHERE titolo LIKE ? LIMIT 10";
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
                prodotto.setId_categoria(rs.getInt("ID_Categoria"));
                prodotti.add(prodotto);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nella ricerca per titolo", e);
        }
        return prodotti;
    }

    public List<Prodotto> doRetrieveAll() {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM prodotto";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            ImmagineProdottoDAO immagineDAO = new ImmagineProdottoDAO();

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzo(rs.getDouble("Prezzo"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setLingua(rs.getString("Lingua"));
                prodotto.setEditore(rs.getString("Editore"));
                prodotto.setDisponibilita(rs.getBoolean("Disponibilita"));
                prodotto.setId_categoria(rs.getInt("ID_Categoria"));

                List<ImmagineProdotto> immagini = immagineDAO.doRetrieveByProdotto(prodotto.getId_prodotto());
                prodotto.setImmagini(immagini);

                prodotti.add(prodotto);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doDelete(int idProdotto) {
        try (Connection con = ConPool.getConnection()) {
            // elimina immagini
            try (PreparedStatement ps = con.prepareStatement("DELETE FROM immagine_prodotto WHERE ID_Prodotto = ?")) {
                ps.setInt(1, idProdotto);
                ps.executeUpdate();
            }
            // elimina prodotto
            try (PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto WHERE ID_Prodotto = ?")) {
                ps.setInt(1, idProdotto);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante l'eliminazione del prodotto", e);
        }
    }

    // Recupera prodotti filtrati, includendo join categoria per filtro tipo
    public List<Prodotto> doRetrieveFiltrati(int idCategoria, String tipo, String lingua, String editore, String autore, String disponibilita, Double prezzoMin, Double prezzoMax) {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            StringBuilder query = new StringBuilder(
                    "SELECT p.* FROM prodotto p JOIN categoria c ON p.ID_Categoria = c.ID_Categoria WHERE p.ID_Categoria = ?"
            );
            List<Object> parameters = new ArrayList<>();
            parameters.add(idCategoria);

            if (tipo != null && !tipo.isEmpty()) {
                query.append(" AND c.Tipo = ?");
                parameters.add(tipo);
            }
            if (lingua != null && !lingua.isEmpty()) {
                query.append(" AND p.Lingua = ?");
                parameters.add(lingua);
            }
            if (editore != null && !editore.isEmpty()) {
                query.append(" AND p.Editore = ?");
                parameters.add(editore);
            }
            if (autore != null && !autore.isEmpty()) {
                query.append(" AND p.Autore = ?");
                parameters.add(autore);
            }
            if (disponibilita != null && !disponibilita.isEmpty()) {
                query.append(" AND p.Disponibilita = ?");
                parameters.add(Boolean.parseBoolean(disponibilita));
            }
            if (prezzoMin != null) {
                query.append(" AND p.Prezzo >= ?");
                parameters.add(prezzoMin);
            }
            if (prezzoMax != null) {
                query.append(" AND p.Prezzo <= ?");
                parameters.add(prezzoMax);
            }

            PreparedStatement ps = con.prepareStatement(query.toString());
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId_prodotto(rs.getInt("ID_Prodotto"));
                prodotto.setTitolo(rs.getString("Titolo"));
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzo(rs.getDouble("Prezzo"));
                prodotto.setAutore(rs.getString("Autore"));
                prodotto.setDataUscita(rs.getDate("Data_Uscita"));
                prodotto.setLingua(rs.getString("Lingua"));
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

    // --- Metodi per filtri dinamici: autori, editori e disponibilità per categoria ---

    private List<String> doRetrieveDistinctString(String campo, int idCategoria) {
        List<String> valori = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String sql = "SELECT DISTINCT " + campo + " FROM prodotto WHERE ID_Categoria = ? AND " + campo + " IS NOT NULL AND " + campo + " <> ''";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCategoria);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                valori.add(rs.getString(campo));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return valori;
    }

    public List<String> doRetrieveAllAutori(int idCategoria) {
        return doRetrieveDistinctString("Autore", idCategoria);
    }

    public List<String> doRetrieveAllEditori(int idCategoria) {
        return doRetrieveDistinctString("Editore", idCategoria);
    }

    public List<Boolean> doRetrieveAllDisponibilita(int idCategoria) {
        List<Boolean> disponibilita = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String sql = "SELECT DISTINCT Disponibilita FROM prodotto WHERE ID_Categoria = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCategoria);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                disponibilita.add(rs.getBoolean("Disponibilita"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return disponibilita;
    }

}