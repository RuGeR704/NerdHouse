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

    public Categoria doRetrieveByNome(String nome) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM categoria WHERE nome = ?");
            ps.setString(1, nome);
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
        return tipi;
    }
}