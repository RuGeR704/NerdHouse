package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public Categoria doRetrieveByID(int id) {

        try(Connection con = ConPool.getConnection()) {
            String sql = "SELECT * FROM categoria WHERE idCategoria = ?";
            PreparedStatement ps = con.prepareStatement(sql);

            //Inserisco ID categoria nella query
            ps.setInt(1, id);

            //Creo la categoria dal database
            ResultSet rs = ps.executeQuery();

            rs.next();

            Categoria cat = new Categoria();
            cat.setIdCategoria(rs.getInt("idCategoria"));
            cat.setNome(rs.getString("nome"));
            cat.setTipo(rs.getString("tipo"));

            return cat;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Categoria> doRetrieveAll() {

        try(Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM categoria";
            ResultSet rs = con.createStatement().executeQuery(query);

            List<Categoria> categorie = new ArrayList<Categoria>();

            while(rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdCategoria(rs.getInt("idCategoria"));
                cat.setNome(rs.getString("nome"));
                cat.setTipo(rs.getString("tipo"));
                categorie.add(cat);
            }

            return categorie;
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
