package Model;

public class Ordine {
    private int id_utente;
    private int id_prodotto;
    private String pagamento;
    private String indirizzoOrdine;
    private String stato;

    public int getId_utente() {
        return id_utente;
    }

    public void setId_utente(int id_utente) {
        this.id_utente = id_utente;
    }

    public int getId_prodotto() {
        return id_prodotto;
    }

    public void setId_prodotto(int id_prodotto) {
        this.id_prodotto = id_prodotto;
    }

    public String getPagamento() {
        return pagamento;
    }

    public void setPagamento(String pagamento) {
        this.pagamento = pagamento;
    }

    public String getIndirizzoOrdine() {
        return indirizzoOrdine;
    }

    public void setIndirizzoOrdine(String indirizzoOrdine) {
        this.indirizzoOrdine = indirizzoOrdine;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }
}
