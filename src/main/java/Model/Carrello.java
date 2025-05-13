package Model;

public class Carrello {
    private int idCarrello;
    private int idUtente;
    private int quantità;
    private double totaleSpesa;

    public int getIdCarrello() {
        return idCarrello;
    }

    public void setIdCarrello(int idCarrello) {
        this.idCarrello = idCarrello;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getQuantità() {
        return quantità;
    }

    public void setQuantità(int quantità) {
        this.quantità = quantità;
    }

    public double getTotaleSpesa() {
        return totaleSpesa;
    }

    public void setTotaleSpesa(double totaleSpesa) {
        this.totaleSpesa = totaleSpesa;
    }
}
