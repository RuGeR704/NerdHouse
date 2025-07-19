package Model;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

public class Prodotto {
    private int id_prodotto;
    private int id_categoria;
    private String titolo;
    private String descrizione;
    private double prezzo;;
    private String lingua;
    private String autore;
    private Date dataUscita;
    private String editore;
    private boolean disponibilita;
    private List<ImmagineProdotto> immagini;

    public int getId_prodotto() {
        return id_prodotto;
    }

    public void setId_prodotto(int id_prodotto) {
        this.id_prodotto = id_prodotto;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public String getLingua() {
        return lingua;
    }

    public void setLingua(String lingua) {
        this.lingua = lingua;
    }

    public String getAutore() {
        return autore;
    }

    public void setAutore(String autore) {
        this.autore = autore;
    }

    public Date getDataUscita() {
        return dataUscita;
    }

    public void setDataUscita(Date dataUscita) {
        this.dataUscita = dataUscita;
    }

    public String getEditore() {
        return editore;
    }

    public void setEditore(String editore) {
        this.editore = editore;
    }

    public boolean isDisponibilità() {
        return disponibilita;
    }

    public void setDisponibilita(boolean disponibilita) {
        this.disponibilita = disponibilita;
    }

    public List<ImmagineProdotto> getImmagini() {
        return immagini;
    }

    public void setImmagini(List<ImmagineProdotto> immagini) {
        this.immagini = immagini;
    }
}
