

import 'package:geldverwalten/Model/DSortie.dart';

import '../Model/ProjetService.dart';
import 'config.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';






void updateSortie(int idSortie, DSortie sortie){}

void deleteProjet(int idProjet){}


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