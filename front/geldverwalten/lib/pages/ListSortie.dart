import 'package:flutter/material.dart';
import 'package:geldverwalten/Model/ProjetService.dart';
import 'package:geldverwalten/Model/sortieService.dart';
import 'package:geldverwalten/drawer/drawer.dart';
import 'package:geldverwalten/pages/Accueil.dart';
import 'package:geldverwalten/pages/ProjetInfo.dart';
import 'package:geldverwalten/widget/Boutton.dart';
import 'package:geldverwalten/widget/EntreePresentation.dart';
import 'package:geldverwalten/widget/SortiePresentation.dart';

import '../Model/soldeService.dart';

class ListSortie extends StatefulWidget {
  const ListSortie({super.key, required this.title});


  final String title;

  @override
  State<ListSortie> createState() => _ListSortieState();
}

class _ListSortieState extends State<ListSortie> {

  final TextEditingController nomprojet = TextEditingController();

  //late Future<List<sortie>> listeSortie;
  late Future<List<Projet>> listProjets;
  late Future<List<solde>> lesolde;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //listeSortie = sortieService().getSortie() ;
    listProjets = ProjetService().getProjet();
    lesolde = soldeService().getSolde() ;
  }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
            drawer: const InkWellDrawer(),
            appBar: AppBar(
              //backgroundColor: Colors.green,
              elevation: 0,
              actions:  [
                FutureBuilder<List<solde>>(
                  future: lesolde,
                  builder: ((context, snapshot){
                    if(snapshot.hasData){
                      return Text(snapshot.data![0].montant.toString(),style: const TextStyle(fontSize: 50),);
                    }else if(snapshot.hasError){

                    }
                    return CircularProgressIndicator();
                  }),
                ),

              ],
            ),

            body: Center(
              child: FutureBuilder<List<Projet>>(
                future: listProjets,
                builder: ((context, snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20,left: 15, right: 15),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Toutes les sorties"),
                              Container(
                                margin: EdgeInsets.only(top: 50,left: 5, right: 5),
                                height: MediaQuery.of(context).size.height/1.3,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.length, //nombre de projets dans la bd
                                    itemBuilder: (context, index) {
                                      Projet _projet = snapshot.data![index];
                                      return InkWell(
                                          onLongPress: () {
                                            //selection
                                          },
                                          onTap: () {

                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5,left: 0,bottom: 5),

                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                    color: Colors.white)
                                              ],
                                            ),
                                            width: 100,
                                            child: SortiePresentation(idProjet: _projet.id, nomProjet: _projet.nomProjet,),
                                          )
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),),
                    );
                  }else if(snapshot.hasError){

                  }

                  return CircularProgressIndicator();
                }),
              ),
            )
          /*SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 20,left: 15, right: 15),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Toutes les sorties"),
                  Container(
                    margin: EdgeInsets.only(top: 50,left: 5, right: 5),
                    height: MediaQuery.of(context).size.height/1.1,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 5, //nombre de projets dans la bd
                        itemBuilder: (context, index) {
                          return InkWell(
                              onLongPress: () {
                                //selection
                              },
                              onTap: () {

                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 5,left: 0,bottom: 5),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        color: Colors.white)
                                  ],
                                ),
                                width: 100,
                                child: SortiePresentation(image: "image", nom: "nom", prix: 15),
                              )
                          );
                        }),
                  ),
                ],
              ),
            ),),
        )*/

        ),
        onWillPop: (){
          print("object");
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return Accueil(title: "title");
              }));
          //Navigator.pop(context,false);
          return Future.value(false);
        });

  }

  Future<void> modifSortie()async{

    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
            elevation: 11,
            contentPadding: const EdgeInsets.all(10.0),
            children: [
              const Text("Quel est le nom de votre projet ??",textAlign: TextAlign.center,style: TextStyle(),),
              const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.eco_outlined,size: 18,),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: TextField(
                        controller: nomprojet,
                        decoration: const InputDecoration.collapsed(
                            border: UnderlineInputBorder(),
                            hintText: ""
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton("Annuler", Colors.green, () { Navigator.pop(context); }),
                  buildButton("Creer", Colors.green, () { }),

                ],
              )
            ],
          );
        });
  }
}
