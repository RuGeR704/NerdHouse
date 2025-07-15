package Model;

import java.awt.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class MetodoPagamentoDAO {

    public void doSave(MetodoPagamento metodoPagamento) throws SQLException {

        try(Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO MetodiPagamento (id_utente, tipo_metodo, numero_carta_ult4, nome_intestatario, scadenza, attivo) VALUES (?,?,?,?,?,?)");

            ps.setInt(1, metodoPagamento.getId_utente());
            ps.setString(2, metodoPagamento.getTipoMetodo());
            ps.setString(3, metodoPagamento.getNumeriFinaliCarta());
            ps.setString(4, metodoPagamento.getNomeIntestatario());
            ps.setString(5, metodoPagamento.getScadenza());
            ps.setBoolean(6, metodoPagamento.isAttivo());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    metodoPagamento.setId_metodo(rs.getInt(1));
                }
            }
        }
    }

    public MetodoPagamento doRetrievebyId (int idMetodo) throws SQLException {
        MetodoPagamento metodoPagamento = new MetodoPagamento();

        try(Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM MetodiPagamento WHERE id_metodo = ?");

            ps.setInt(1, idMetodo);

            ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    metodoPagamento.setId_metodo(rs.getInt("id_metodo"));
                    metodoPagamento.setId_utente(rs.getInt("id_utente"));
                    metodoPagamento.setTipoMetodo(rs.getString("tipo_metodo"));
                    metodoPagamento.setNumeriFinaliCarta(rs.getString("numero_carta_ult4"));
                    metodoPagamento.setNomeIntestatario(rs.getString("nome_intestatario"));
                    metodoPagamento.setScadenza(rs.getString("scadenza"));
                    metodoPagamento.setAttivo(rs.getBoolean("attivo"));
                }
            } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            }
        return metodoPagamento;
    }

    public List<MetodoPagamento> doRetrievebyUtente(Utente utente) throws SQLException {
        List<MetodoPagamento> metodiPagamento = new ArrayList<>();
        int idUtente = utente.getId();

        System.out.println("DEBUG: idUtente passato al DAO: " + idUtente);

        try(Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM MetodiPagamento WHERE id_utente = ?");

            ps.setInt(1, idUtente);

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                System.out.println("DEBUG: Metodo pagamento trovato - id_metodo: " + rs.getInt("id_metodo") +
                        ", tipo: " + rs.getString("tipo_metodo"));
                MetodoPagamento metodoPagamento = new MetodoPagamento();
                metodoPagamento.setId_metodo(rs.getInt("id_metodo"));
                metodoPagamento.setId_utente(rs.getInt("id_utente"));
                metodoPagamento.setTipoMetodo(rs.getString("tipo_metodo"));
                metodoPagamento.setNumeriFinaliCarta(rs.getString("numero_carta_ult4"));
                metodoPagamento.setNomeIntestatario(rs.getString("nome_intestatario"));
                metodoPagamento.setScadenza(rs.getString("scadenza"));
                metodoPagamento.setAttivo(rs.getBoolean("attivo"));
                metodiPagamento.add(metodoPagamento);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        System.out.println("DEBUG: Totale metodi recuperati: " + metodiPagamento.size());
        return metodiPagamento;
    }

    public void doUpdate(MetodoPagamento metodo) throws SQLException {
        try(Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE MetodiPagamento SET tipo_metodo = ?, numero_carta_ult4 = ?, nome_intestatario = ?, scadenza = ?, attivo = ? WHERE id_metodo = ?");

            ps.setString(1, metodo.getTipoMetodo());
            ps.setString(2, metodo.getNumeriFinaliCarta());
            ps.setString(3, metodo.getNomeIntestatario());
            ps.setString(4, metodo.getScadenza());
            ps.setBoolean(5, metodo.isAttivo());
            ps.setInt(6, metodo.getId_metodo());

            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void doDelete(int idMetodo) throws SQLException {
        String sql = "DELETE FROM MetodiPagamento WHERE id_metodo = ?";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idMetodo);
            ps.executeUpdate();
        }
    }

    }

