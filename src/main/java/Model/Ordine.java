package Model;

import java.sql.Timestamp;

public class Ordine {
    private int idOrdine;
    private int idProdotto;
    private int idUtente;
    private String pagamento;
    private String indirizzoOrdine;
    private String stato;
    private Timestamp dataOrdine;

    public int getIdOrdine() {
        return idOrdine;
    }

    public void setIdOrdine(int idOrdine) {
        this.idOrdine = idOrdine;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getIdProdotto() {
        return idProdotto;
    }

    public void setIdProdotto(int idProdotto) {
        this.idProdotto = idProdotto;
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

    public Timestamp getDataOrdine() {
        return dataOrdine;
    }

    public void setDataOrdine(Timestamp dataOrdine) {
        this.dataOrdine = dataOrdine;
    }
}
