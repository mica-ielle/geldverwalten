
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/config.dart';


class Projet {

    final int id;
    final int idUser;
    final int statut;
    final String nomProjet;

    const Projet({
        required this.id,
        required this.idUser,
        required this.statut,
        required this.nomProjet
    });

    factory Projet.fromJson(Map<String, dynamic> json){
        return Projet(id: json['id'],idUser: json['idUser'], statut: json['statut'], nomProjet: json['nomProjet']);
    }
}

class ProjetService{
    Future<List<Projet>> getProjet() async {
        final response = await http
            .get(Uri.parse(hostUrl+"getProjets"),headers: {
            "content-type":"application/json",
            'Accept':'*/*',
            'Access-Control-Allow-Origin':"*"
        },);

        if(response.statusCode==200){
            final data = jsonDecode(response.body);

            final List<Projet> list = [];

            for(var i=0; i<data.length; i++){
                final entry = data[i];
                list.add(Projet.fromJson(entry));
            }
            return list;
        }else{
            throw Exception('HTTP failed ${response.statusCode}');
        }
    }
}

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