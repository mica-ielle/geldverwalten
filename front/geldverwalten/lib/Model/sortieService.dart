
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
}