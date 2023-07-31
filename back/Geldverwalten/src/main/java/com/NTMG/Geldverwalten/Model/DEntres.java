package com.NTMG.Geldverwalten.Model;

import java.util.Date;

public class DEntres {


    private int id;
    private int idUser;
    private int montant;
    private String message;
    private Date date;

    public DEntres() {
    }

    public DEntres(String message,int montant) {
        this.message = message;
        this.montant = montant;
    }
    public DEntres(Date date,String message,int montant) {
        this.date = date;
        this.message = message;
        this.montant = montant;
    }
    public DEntres(int idUser,Date date,String message,int montant) {
        this.idUser = idUser;
        this.date = date;
        this.message = message;
        this.montant = montant;
    }
    public DEntres(int id, int idUser, int montant, String message, Date date) {
        this.id = id;
        this.idUser = idUser;
        this.montant = montant;
        this.message = message;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getMontant() {
        return montant;
    }

    public void setMontant(int montant) {
        this.montant = montant;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
