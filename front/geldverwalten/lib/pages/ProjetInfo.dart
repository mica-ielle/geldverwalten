import 'package:flutter/material.dart';
import 'package:geldverwalten/Model/ProjetService.dart';
import 'package:geldverwalten/Model/sortieService.dart';
import 'package:geldverwalten/pages/Accueil.dart';
import 'package:geldverwalten/widget/Boutton.dart';

import '../Model/soldeService.dart';

class ProjetInfo extends StatefulWidget {
  const ProjetInfo({super.key, required this.title});


  final String title;

  @override
  State<ProjetInfo> createState() => _ProjetInfoState();
}

class _ProjetInfoState extends State<ProjetInfo> {

  final TextEditingController raison = TextEditingController();
  final TextEditingController montant = TextEditingController();

  late Projet selectedP = Projet(id: 0, idUser: 0, statut: 0, nomProjet: "aucun projet selectionné");


  late Future<List<solde>> lesolde;
  late Future<List<Projet>> listProjets;
  late Future<List<sortie>> listSorties;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lesolde = soldeService().getSolde() ;
    listProjets = ProjetService().getProjet();
    listSorties = sortieService().getSortieProjet(0);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded),onPressed: (){Navigator.pop(context);},),
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
              //backgroundColor: Colors.green,
              elevation: 0,
            ),

            body: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FutureBuilder<List<Projet>>(
                      future: listProjets,
                      builder: ((context, snapshot){
                        if(snapshot.hasData){
                          return SizedBox(
                            height: MediaQuery.of(context).size.height/7,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length, //nombre de projets dans la bd
                                itemBuilder: (context, index) {
                                  Projet _projet = snapshot.data![index];
                                  return InkWell(
                                      onLongPress: () {
                                        //selection
                                      },
                                      onTap: () {
                                        setState(() {
                                          print(_projet.nomProjet);
                                          selectedP = Projet(id: _projet.id, idUser: _projet.idUser, statut: _projet.statut, nomProjet: _projet.nomProjet);

                                          listSorties = sortieService().getSortieProjet(selectedP.id);
                                          print(selectedP.nomProjet);
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5,left: 10,bottom: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 1),
                                                blurRadius: 2,
                                                color: Colors.grey)
                                          ],
                                        ),
                                        width: 100,
                                        child: Text(_projet.nomProjet),
                                      )
                                  );
                                }),
                          );
                        }else if(snapshot.hasError){

                        }
                        return CircularProgressIndicator();
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 15, right: 15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(selectedP.nomProjet),
                          FutureBuilder<List<sortie>>(
                            future: listSorties,
                            builder: ((context, snapshot){
                              if(snapshot.hasData){
                                return Container(
                                  margin: EdgeInsets.only(top: 20,left: 15, right: 15),
                                  height: MediaQuery.of(context).size.height/1.8,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.length, //nombre de projets dans la bd
                                      itemBuilder: (context, index) {
                                        sortie _sortie = snapshot.data![index];
                                        return InkWell(
                                            onLongPress: () {
                                              //selection
                                            },
                                            onTap: () {

                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5,left: 0,bottom: 5),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      offset: Offset(0, 1),
                                                      blurRadius: 2,
                                                      color: Colors.grey)
                                                ],
                                              ),
                                              width: 100,
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(_sortie.message),Text("${_sortie.montant}")],),
                                            )
                                        );
                                      }),
                                );
                              }else if(snapshot.hasError){

                              }
                              return Container(height: 20+MediaQuery.of(context).size.height/1.8,);
                            }),
                          ),
                        ],
                      ),
                    ),
                    buildButton("Nouvelle sortie", Colors.green, () { newSortie(); }),
                  ],
                )
            )

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

  Future<void> newSortie()async{

    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return SimpleDialog(
            title: const Text("Informations sur la sortie",textAlign: TextAlign.center,style: TextStyle(),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
            elevation: 11,
            contentPadding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
            children: [
              const SizedBox(height: 10,),
              const Text("Raison",textAlign: TextAlign.start,style: TextStyle(),),
              const SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.eco_outlined,size: 18,),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                      child: TextField(
                        controller: raison,
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
              const Text("Montant",textAlign: TextAlign.start,style: TextStyle(),),
              const SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.eco_outlined,size: 18,),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                      child: TextField(
                        controller: montant,
                        keyboardType: TextInputType.number,
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
                  buildButton("Creer", Colors.green, () {
                    setSortie(raison.text,montant.text,selectedP.id);

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const ProjetInfo(title: "title");
                            }));
                  }),

                ],
              )
            ],
          );
        });
  }
}
