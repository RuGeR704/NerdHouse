package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDAO {

    public void doSave(Utente utente) throws SQLException {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO Utente (Nome, Cognome, Email, Password, Data_Nascita, Indirizzo, Telefono) VALUES(?,?,?,?,?,?,?)");
            ps.setString(1, utente.getNome());
            ps.setString(2, utente.getCognome());
            ps.setString(3, utente.getEmail());
            ps.setString(4, utente.getPassword());
            ps.setDate(5, utente.getDataNascita());
            ps.setString(6, utente.getIndirizzo());
            ps.setString(7, utente.getTelefono());

            int rows = ps.executeUpdate();
            System.out.println("Righe inserite: " + rows);
            if (rows != 1) {
                throw new RuntimeException("INSERT ERROR");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void doUpdate(Utente utente) throws SQLException {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE utente SET nome = ?, cognome = ?, email = ?, telefono = ?, data_nascita = ? WHERE id_utente = ?"
            );
            ps.setString(1, utente.getNome());
            ps.setString(2, utente.getCognome());
            ps.setString(3, utente.getEmail());
            ps.setString(4, utente.getTelefono());
            ps.setDate(5, utente.getDataNascita());
            ps.setInt(6, utente.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante l'aggiornamento dell'utente", e);
        }

    }

    public void doUpdatePassword(Utente utente, String newPassword) throws SQLException {
        int idUtente = utente.getId();

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE utente SET password = ? WHERE id_utente = ?");

            ps.setString(1, newPassword);
            ps.setInt(2, idUtente);

            int updated = ps.executeUpdate();

            if (updated == 1) {
                utente.setHashedPassword(newPassword);
            } else {
                throw new SQLException("Nessuna riga aggiornata, ID utente non trovato.");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante l'aggiornamento dell'utente", e);
        }
    }


    public Utente doRetrieveByUsernamePassword(String email, String password) throws SQLException {
        String query = "SELECT * FROM Utente WHERE Email = ? AND password = SHA1(?)";

        ResultSet rs = null;
        Utente utente = null;

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(query);
            //Imposta i parametri nella query
            ps.setString(1, email);
            ps.setString(2, password);

            //Esecuzione query
            rs = ps.executeQuery();

            //Se ci sono risultati allora crea l'oggetto UTENTE
            if (rs.next()) {
                utente = new Utente();
                utente.setId(rs.getInt("id_utente"));
                utente.setNome(rs.getString("nome"));
                utente.setCognome(rs.getString("cognome"));
                utente.setEmail(rs.getString("email"));
                utente.setHashedPassword(rs.getString("password"));
                utente.setDataNascita(rs.getDate("data_nascita"));
                utente.setIndirizzo(rs.getString("indirizzo"));
                utente.setTelefono(rs.getString("telefono"));
                utente.setAdmin(rs.getBoolean("is_admin"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }
        return utente;
    }
}
