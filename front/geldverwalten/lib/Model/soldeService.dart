
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/config.dart';


class solde{
  final int montant;

  const solde({
    required this.montant,
  });

  factory solde.fromJson(Map<String, dynamic> json){
    return solde(montant: json['montant']);
  }
}

class soldeService{
  Future<List<solde>> getSolde() async {
    final response = await http
        .get(Uri.parse(hostUrl+"solde"),headers: {
      "content-type":"application/json",
      'Accept':'*/*',
      'Access-Control-Allow-Origin':"*"
    },);

    if(response.statusCode==200){
      final data = jsonDecode(response.body);

      final List<solde> lsolde = [];
      print(data.length);
      print(data);

      for(var i=0; i<data.length; i++){
        final entry = data;
    lsolde.add(solde.fromJson(entry));
      }
      return lsolde;
    }else{
      throw Exception('HTTP failed ${response.statusCode}');
    }
  }
}