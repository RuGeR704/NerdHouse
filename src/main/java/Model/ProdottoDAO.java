package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    public List<Prodotto> doRetrieveByCategoria(int idCategoria) {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Prodotto WHERE ID_Categoria = ?");
            ps.setInt(1, idCategoria);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId_prodotto(rs.getInt("ID_Prodotto"));
                p.setTitolo(rs.getString("Titolo"));
                p.setDescrizione(rs.getString("Descrizione"));
                p.setPrezzo(rs.getFloat("Prezzo"));
                p.setAutore(rs.getString("Autore"));
                p.setEditore(rs.getString("Editore"));
                p.setDataUscita(rs.getDate("Data_Uscita"));
                p.setLingua(rs.getString("Lingua"));
                p.setDisponibilita(rs.getBoolean("Disponibilita"));
                p.setId_categoria(rs.getInt("ID_Categoria"));
                prodotti.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
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
    public List<Prodotto> doRetrieveFiltrati(Integer idCategoria, String tipo, String lingua, String editore, String autore, String disponibilita, Double prezzoMin, Double prezzoMax) {
        List<Prodotto> prodotti = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.* FROM Prodotto p JOIN Categoria c ON p.ID_Categoria = c.ID_Categoria WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (idCategoria != null) {
            sql.append("AND p.ID_Categoria = ? ");
            params.add(idCategoria);
        }
        if (tipo != null && !tipo.isEmpty()) {
            sql.append("AND c.Tipo = ? ");
            params.add(tipo);
        }
        if (lingua != null && !lingua.isEmpty()) {
            sql.append("AND p.Lingua = ? ");
            params.add(lingua);
        }
        if (editore != null && !editore.isEmpty()) {
            sql.append("AND p.Editore = ? ");
            params.add(editore);
        }
        if (autore != null && !autore.isEmpty()) {
            sql.append("AND p.Autore = ? ");
            params.add(autore);
        }
        if (disponibilita != null && !disponibilita.isEmpty()) {
            sql.append("AND p.Disponibilita = ? ");
            params.add(Boolean.parseBoolean(disponibilita));
        }
        if (prezzoMin != null) {
            sql.append("AND p.Prezzo >= ? ");
            params.add(prezzoMin);
        }
        if (prezzoMax != null) {
            sql.append("AND p.Prezzo <= ? ");
            params.add(prezzoMax);
        }

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId_prodotto(rs.getInt("ID_Prodotto"));
                p.setTitolo(rs.getString("Titolo"));
                p.setPrezzo(rs.getDouble("Prezzo"));
                p.setLingua(rs.getString("Lingua"));
                p.setAutore(rs.getString("Autore"));
                p.setDataUscita(rs.getDate("Data_Uscita"));
                p.setDescrizione(rs.getString("Descrizione"));
                p.setEditore(rs.getString("Editore"));
                p.setDisponibilita(rs.getBoolean("Disponibilita"));
                p.setId_categoria(rs.getInt("ID_Categoria"));

                prodotti.add(p);
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

    // Metodo per recuperare tutti gli autori, eventualmente filtrati per categoria (se idCategoria != null

    public List<String> doRetrieveAllAutori(Integer idCategoria) {
        List<String> autori = new ArrayList<>();
        String sql = (idCategoria == null)
                ? "SELECT DISTINCT Autore FROM Prodotto WHERE Autore IS NOT NULL AND Autore <> '' ORDER BY Autore ASC"
                : "SELECT DISTINCT Autore FROM Prodotto WHERE ID_Categoria = ? AND Autore IS NOT NULL AND Autore <> '' ORDER BY Autore ASC";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (idCategoria != null) {
                ps.setInt(1, idCategoria);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String autore = rs.getString("Autore");
                    if (autore != null && !autore.isEmpty()) {
                        autori.add(autore);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nel recupero autori", e);
        }
        System.out.println("[DEBUG DAO] Autori trovati: " + autori);
        return autori;
    }

    // ✅ Recupero editori sempre non null e con controllo stringa
    public List<String> doRetrieveAllEditori(Integer idCategoria) {
        List<String> editori = new ArrayList<>();
        String sql = (idCategoria == null)
                ? "SELECT DISTINCT Editore FROM Prodotto WHERE Editore IS NOT NULL AND Editore <> '' ORDER BY Editore ASC"
                : "SELECT DISTINCT Editore FROM Prodotto WHERE ID_Categoria = ? AND Editore IS NOT NULL AND Editore <> '' ORDER BY Editore ASC";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (idCategoria != null) {
                ps.setInt(1, idCategoria);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String editore = rs.getString("Editore");
                    if (editore != null && !editore.isEmpty()) {
                        editori.add(editore);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nel recupero editori", e);
        }
        System.out.println("[DEBUG DAO] Editori trovati: " + editori);
        return editori;
    }

    public List<String> doRetrieveAutoriFiltrati(Integer idCategoria, String tipo, String lingua, String editore, String autore, String disponibilita, Double prezzoMin, Double prezzoMax) {
        List<String> autori = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT p.Autore FROM Prodotto p JOIN Categoria c ON p.ID_Categoria = c.ID_Categoria WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (idCategoria != null) {
            sql.append("AND p.ID_Categoria = ? ");
            params.add(idCategoria);
        }
        if (tipo != null && !tipo.isEmpty()) {
            sql.append("AND c.Tipo = ? ");
            params.add(tipo);
        }
        if (lingua != null && !lingua.isEmpty()) {
            sql.append("AND p.Lingua = ? ");
            params.add(lingua);
        }
        if (editore != null && !editore.isEmpty()) {
            sql.append("AND p.Editore = ? ");
            params.add(editore);
        }
        if (autore != null && !autore.isEmpty()) {
            sql.append("AND p.Autore = ? ");
            params.add(autore);
        }
        if (disponibilita != null && !disponibilita.isEmpty()) {
            sql.append("AND p.Disponibilita = ? ");
            params.add(Boolean.parseBoolean(disponibilita));
        }
        if (prezzoMin != null) {
            sql.append("AND p.Prezzo >= ? ");
            params.add(prezzoMin);
        }
        if (prezzoMax != null) {
            sql.append("AND p.Prezzo <= ? ");
            params.add(prezzoMax);
        }

        sql.append("ORDER BY p.Autore ASC");

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String a = rs.getString("Autore");
                if (a != null && !a.isEmpty()) {
                    autori.add(a);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return autori;
    }

    public List<String> doRetrieveEditoriFiltrati(Integer idCategoria, String tipo, String lingua, String editore, String autore, String disponibilita, Double prezzoMin, Double prezzoMax) {
        List<String> editori = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT p.Editore FROM Prodotto p JOIN Categoria c ON p.ID_Categoria = c.ID_Categoria WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (idCategoria != null) {
            sql.append("AND p.ID_Categoria = ? ");
            params.add(idCategoria);
        }
        if (tipo != null && !tipo.isEmpty()) {
            sql.append("AND c.Tipo = ? ");
            params.add(tipo);
        }
        if (lingua != null && !lingua.isEmpty()) {
            sql.append("AND p.Lingua = ? ");
            params.add(lingua);
        }
        if (editore != null && !editore.isEmpty()) {
            sql.append("AND p.Editore = ? ");
            params.add(editore);
        }
        if (autore != null && !autore.isEmpty()) {
            sql.append("AND p.Autore = ? ");
            params.add(autore);
        }
        if (disponibilita != null && !disponibilita.isEmpty()) {
            sql.append("AND p.Disponibilita = ? ");
            params.add(Boolean.parseBoolean(disponibilita));
        }
        if (prezzoMin != null) {
            sql.append("AND p.Prezzo >= ? ");
            params.add(prezzoMin);
        }
        if (prezzoMax != null) {
            sql.append("AND p.Prezzo <= ? ");
            params.add(prezzoMax);
        }

        sql.append("ORDER BY p.Editore ASC");

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String e = rs.getString("Editore");
                if (e != null && !e.isEmpty()) {
                    editori.add(e);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return editori;
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