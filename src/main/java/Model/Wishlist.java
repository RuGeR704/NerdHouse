package Model;

import java.time.LocalDate;

public class Wishlist {
    private int idWishlist;
    private int idUser;
    private LocalDate dataAggiunta;

    public int getIdWishlist() {
        return idWishlist;
    }

    public void setIdWishlist(int idWhishlist) {
        this.idWishlist = idWhishlist;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public LocalDate getDataAggiunta() {
        return dataAggiunta;
    }

    public void setDataAggiunta(LocalDate dataAggiunta) {
        this.dataAggiunta = dataAggiunta;
    }
}
