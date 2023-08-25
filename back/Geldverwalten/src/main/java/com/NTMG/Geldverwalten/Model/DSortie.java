package com.NTMG.Geldverwalten.Model;

import java.util.Date;

public class DSortie {


    private int id;
    private int idProjet;
    private String nomProjet;
    private int montant;
    private String message;
    private String val;
    private Date date;

    public DSortie() {
    }

    public DSortie(int montant, String message) {
        this.montant = montant;
        this.message = message;
    }
    public DSortie(int montant, String message, String val, Date date) {
        this.montant = montant;
        this.message = message;
        this.val = val;
        this.date = date;
    }

    public DSortie(int idProjet, int montant, String message, String val, Date date) {
        this.idProjet = idProjet;
        this.montant = montant;
        this.message = message;
        this.val = val;
        this.date = date;
    }
    public DSortie(int idProjet,String nomProjet, int montant, String message, String val, Date date) {
        this.idProjet = idProjet;
        this.nomProjet = nomProjet;
        this.montant = montant;
        this.message = message;
        this.val = val;
        this.date = date;
    }

    public int getIdProjet() {
        return idProjet;
    }

    public void setIdProjet(int idProjet) {
        this.idProjet = idProjet;
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

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomProjet() {
        return nomProjet;
    }

    public void setNomProjet(String nomProjet) {
        this.nomProjet = nomProjet;
    }
}
