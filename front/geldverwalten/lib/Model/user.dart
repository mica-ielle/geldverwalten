import 'dart:core';

 class user {

    final int id;
    final String nom;
    final String prenom;
    final String pseudo;
    final String email;
    final String motdepasse;
    final String token;

    user(
        this.id,
        this.token,
    {
        required this.nom,
        required this.prenom,
        required this.pseudo,
        required this.email,
        required this.motdepasse
    });


}
