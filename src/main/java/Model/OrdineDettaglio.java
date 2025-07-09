package Model;

import java.sql.Timestamp;

public class OrdineDettaglio {
    private int idProdotto;
    private String titoloProdotto;
    private String pagamento;
    private String indirizzoOrdine;
    private String stato;
    private Timestamp dataOrdine;

    public int getIdProdotto() {
        return idProdotto;
    }

    public void setIdProdotto(int idProdotto) {
        this.idProdotto = idProdotto;
    }

    public String getTitoloProdotto() {
        return titoloProdotto;
    }

    public void setTitoloProdotto(String titoloProdotto) {
        this.titoloProdotto = titoloProdotto;
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
