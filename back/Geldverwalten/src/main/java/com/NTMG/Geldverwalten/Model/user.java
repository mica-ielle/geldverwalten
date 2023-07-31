package com.NTMG.Geldverwalten.Model;

public class user {

    private int id;
    private String nom;
    private String prenom;
    private String pseudo;
    private String email;
    private String motdepasse;
    private String token;


    public user() {
    }

    public user(String email, String motdepasse) {
        this.email = email;
        this.motdepasse = motdepasse;
    }

    public user(int id, String nom, String prenom, String pseudo, String email, String motdepasse, String token) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.pseudo = pseudo;
        this.email = email;
        this.motdepasse = motdepasse;
        this.token = token;
    }

    public user(String nom, String prenom, String pseudo, String email, String motdepasse, String token) {
        this.nom = nom;
        this.prenom = prenom;
        this.pseudo = pseudo;
        this.email = email;
        this.motdepasse = motdepasse;
        this.token = token;
    }
    public user(String nom, String prenom, String pseudo, String email) {
        this.nom = nom;
        this.prenom = prenom;
        this.pseudo = pseudo;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotdepasse() {
        return motdepasse;
    }

    public void setMotdepasse(String motdepasse) {
        this.motdepasse = motdepasse;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
