package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public Categoria doRetrieveByID(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM categoria WHERE id_categoria = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdCategoria(rs.getInt("id_categoria"));
                cat.setNome(rs.getString("nome"));
                cat.setTipo(rs.getString("tipo"));
                return cat;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Categoria doRetrieveByTipo(String tipo) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM categoria WHERE tipo = ?");
            ps.setString(1, tipo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria"));
                categoria.setNome(rs.getString("nome"));
                categoria.setTipo(rs.getString("tipo"));
                return categoria;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recuperare la categoria per nome", e);
        }
    }

    public List<Categoria> doRetrieveAll() {
        List<Categoria> categorie = new ArrayList<>();

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT ID_Categoria, Nome, Tipo FROM Categoria")) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setIdCategoria(rs.getInt("ID_Categoria"));
                c.setNome(rs.getString("Nome"));
                c.setTipo(rs.getString("Tipo"));
                categorie.add(c);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero delle categorie", e);
        }

        return categorie;
    }

    public List<String> doRetrieveAllTipi() {
        List<String> tipi = new ArrayList<>();
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT DISTINCT tipo FROM categoria WHERE tipo IS NOT NULL AND tipo <> ''")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tipi.add(rs.getString("tipo"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tipi;//
    }
}