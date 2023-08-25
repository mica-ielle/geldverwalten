
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/config.dart';


class entree{
  final int montant;
  final String origine;
  final String date;

  const entree({
    required this.montant,
    required this.origine,
    required this.date
  });

  factory entree.fromJson(Map<String, dynamic> json){
    return entree(montant: json['montant'], origine: json['message'], date: json['date']);
  }
}

class entreeService{
  Future<List<entree>> getEntree() async {
    final response = await http
        .get(Uri.parse(hostUrl+"getEntree"),headers: {
      "content-type":"application/json",
      'Accept':'*/*',
      'Access-Control-Allow-Origin':"*"
    },);

    if(response.statusCode==200){
      final data = jsonDecode(response.body);

      final List<entree> list = [];

      for(var i=0; i<data.length; i++){
        final entry = data[i];
        list.add(entree.fromJson(entry));
      }
      return list;
    }else{
      throw Exception('HTTP failed ${response.statusCode}');
    }
  }
}