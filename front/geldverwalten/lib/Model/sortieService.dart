
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/config.dart';


class sortie{
  final String nomProjet;
  final int montant;
  final String message;
  final String date;

  const sortie({
    required this.nomProjet,
    required this.montant,
    required this.message,
    required this.date
  });

  factory sortie.fromJson(Map<String, dynamic> json){
    return sortie(nomProjet: json['nomProjet'], montant: json['montant'], message: json['message'], date: json['date']);
  }
}

class sortieService{
  Future<List<sortie>> getSortie() async {
    final response = await http
        .get(Uri.parse(hostUrl+"getSortie"),headers: {
      "content-type":"application/json",
      'Accept':'*/*',
      'Access-Control-Allow-Origin':"*"
    },);

    if(response.statusCode==200){
      final data = jsonDecode(response.body);

      final List<sortie> list = [];

      for(var i=0; i<data.length; i++){
        final entry = data[i];
        list.add(sortie.fromJson(entry));
      }
      return list;
    }else{
      throw Exception('HTTP failed ${response.statusCode}');
    }
  }

  Future<List<sortie>> getSortieProjet(int idProjet) async {
    final response = await http
        .get(Uri.parse(hostUrl+"getProjet/$idProjet"),headers: {
      "content-type":"application/json",
      'Accept':'*/*',
      'Access-Control-Allow-Origin':"*"
    },);

    if(response.statusCode==200){
      final data = jsonDecode(response.body);

      final List<sortie> list = [];

      for(var i=0; i<data.length; i++){
        final entry = data[i];
        list.add(sortie.fromJson(entry));
      }
      return list;
    }else{
      throw Exception('HTTP failed ${response.statusCode}');
    }
  }

}
void setSortie(String raison, String montant , int idProjet) async {
  var data =
  {
    "montant" : montant,
    "message" : raison
  };

  final response = await http
      .post(Uri.parse(hostUrl+"addSortie/$idProjet"),headers: {
    "content-type":"application/json",
    'Accept':'*/*',
    'Access-Control-Allow-Origin':"*"
  },
      body: jsonEncode(data)
  );

  if(response.statusCode==200){
    final res = jsonDecode(response.body);


    return res;
  }else{
    throw Exception('HTTP failed ${response.statusCode}');
  }
}