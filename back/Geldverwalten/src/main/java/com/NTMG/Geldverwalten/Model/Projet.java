package com.NTMG.Geldverwalten.Model;

public class Projet {

    private int id;
    private int idUser;
    private String statut;
    private String nomProjet;

    public Projet() {
    }

    public Projet(int id,int idUser, String statut, String nomProjet) {
        this.id = id;
        this.idUser = idUser;
        this.statut = statut;
        this.nomProjet = nomProjet;
    }

    public Projet(String statut, String nomProjet) {
        this.statut = statut;
        this.nomProjet = nomProjet;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getNomProjet() {
        return nomProjet;
    }

    public void setNomProjet(String nomProjet) {
        this.nomProjet = nomProjet;
    }
}
