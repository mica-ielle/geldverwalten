import 'package:flutter/material.dart';
import 'package:geldverwalten/Model/soldeService.dart';
import 'package:geldverwalten/api/ApiCall.dart';
import 'package:geldverwalten/drawer/drawer.dart';
import 'package:geldverwalten/pages/Accueil.dart';
import 'package:geldverwalten/pages/ProjetInfo.dart';
import 'package:geldverwalten/widget/Boutton.dart';

import '../Model/entreeServices.dart';
import '../Model/soldeService.dart';

class AddEntree extends StatefulWidget {
  const AddEntree({super.key, required this.title});


  final String title;

  @override
  State<AddEntree> createState() => _AddEntreeState();
}

class _AddEntreeState extends State<AddEntree> {


  final TextEditingController origine = TextEditingController();
  final TextEditingController montant = TextEditingController();

  late Future<List<entree>> listeEntree;
  late Future<List<solde>> lesolde;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listeEntree = entreeService().getEntree() ;
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

            body: SingleChildScrollView(
              child: Center(
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("Les 3 dernières entrées"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/6,
                        child: FutureBuilder<List<entree>>(
                          future: listeEntree,
                          builder: ((context, snapshot){
                            if(snapshot.hasData){
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3, //nombre de projets dans la bd
                                  itemBuilder: (context, index) {
                                    int taille = snapshot.data!.length-1;
                                    entree _entree = snapshot.data![taille-index];
                                    return InkWell(
                                        onLongPress: () {
                                          //selection
                                        },
                                        onTap: () {

                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(top: 40,left:5,right: 5,bottom: 5),
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
                                            width: MediaQuery.of(context).size.width/3.3,
                                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text(_entree.origine),Text("${_entree.montant}"),],)
                                        )
                                    );
                                  });
                            }else if(snapshot.hasError){

                            }

                            return CircularProgressIndicator();
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 5),
                        child: Text("Nouvelle Entrée"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100))),
                        height: MediaQuery.of(context).size.height/1.81,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60,left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: const [SizedBox(width: 20,),Text("Raison",textAlign: TextAlign.start,style: TextStyle(),),],
                              ),
                              const SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.eco_outlined,size: 24,),
                                  SizedBox(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width / 1.4,
                                    child: Center(
                                      child: TextField(
                                        controller: origine,
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
                              Row( mainAxisAlignment: MainAxisAlignment.start,
                                children: const [SizedBox(width: 20,),Text("Montant",textAlign: TextAlign.start,style: TextStyle(),),],
                              ),
                              const SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.eco_outlined,size: 24,),
                                  SizedBox(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width / 1.4,
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
                              const SizedBox(height: 120,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildButton("Valider l'entrée", Colors.green, () {

                                    print("raison: "+origine.text);
                                    print("montant: "+montant.text);

                                    addEntree(origine.text,int.parse(montant.text) );

                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return const AddEntree(title: "title");
                                            }));

                                  }),

                                ],
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),

                    ],
                  )),
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

}
