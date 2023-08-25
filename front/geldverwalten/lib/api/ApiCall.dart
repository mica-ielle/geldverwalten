

import 'package:geldverwalten/Model/DSortie.dart';

import '../Model/Projet.dart';
import 'config.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void createProjet(String nomProjet)async{

  var data =
  {
    "nomProjet" : nomProjet
  };


  print("load projet");

  const url = hostUrl+'createProjet';print("body1");
  final uri = Uri.parse(url);print("body2");
  final response = await http.post(uri,
      headers: {
    "content-type":"application/json",
      'Accept':'*/*',
        'Access-Control-Allow-Origin':"*"
      },
      body: jsonEncode(data));print("body3");
  final body = response.body;

  print("body");
  print(body);

  final json = jsonDecode(body);

  print(json);
  print("projet loaded");

  return json;
}

void addEntree(String origine, int montant)async{


  var data =
  {
    "montant" : montant,
    "message" : origine
  };


  print("load entree");

  const url = hostUrl+'addEntree';
  final uri = Uri.parse(url);
  final response = await http.post(uri,
      headers: {"content-type":"application/json"},
      body: jsonEncode(data));
  final body = response.body;

  print("body");
  print(body);

  final json = jsonDecode(body);

  print("entree loaded");

  return json;
}

/*void addSortie(int idProjet, DSortie sortie)async{

  var data =
  {
    "montant" : sortie.montant,
    "message" : sortie.message
  };


  print("load sortie");

  const url = hostUrl+'addSortie/'+idProjet;
  final uri = Uri.parse(url);
  final response = await http.post(uri,
      headers: {"content-type":"application/json"},
      body: jsonEncode(data));
  final body = response.body;

  print("body");
  print(body);

  final json = jsonDecode(body);

  print("sortie loaded");

  return json;
}*/

void updateSortie(int idSortie, DSortie sortie){}

void deleteProjet(int idProjet){}

void getProjet(int idProjet){}

void nbProjet() async {
  print("get nb projet");

  const url = hostUrl + 'nbProjet';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);


  print("nb projet loaded");
  return json;
}


Future<int> getSolde()async {

  print("get solde");

  const url = hostUrl + 'solde';
  final uri = Uri.parse(url);
  final response = await http.get(uri,
    headers: {
      "content-type":"application/json",
      'Accept':'*/*',
      'Access-Control-Allow-Origin':"*"
    },);
  final body = response.body;
  final json = jsonDecode(body);

  print(json);

  print("solde loaded");
  return await json;

}



void getSortie()async {
  print("get sortie");

  const url = hostUrl + 'getSortie';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);


  print("sortie loaded");
  return json;
}



void LoadOrder() async{


  var data =
  {
    "userId" : "utilisateurActuel.id"
  };


  print("load orders");
  const url = hostUrl+'api/order/user';
  final uri = Uri.parse(url);
  final response = await http.post(uri,
      headers: {"content-type":"application/json"},
      body: jsonEncode(data));
  final body = response.body;
  print("body");
  print(body);
  final json = jsonDecode(body);
  int j=0;




  print("orders loaded");
}