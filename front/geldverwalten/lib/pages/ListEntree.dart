import 'package:flutter/material.dart';
import 'package:geldverwalten/api/ApiCall.dart';
import 'package:geldverwalten/Model/entreeServices.dart';
import 'package:geldverwalten/drawer/drawer.dart';
import 'package:geldverwalten/pages/ProjetInfo.dart';
import 'package:geldverwalten/widget/Boutton.dart';
import 'package:geldverwalten/widget/EntreePresentation.dart';


class ListEntree extends StatefulWidget {
  const ListEntree({super.key, required this.title});


  final String title;

  @override
  State<ListEntree> createState() => _ListEntreeState();
}

class _ListEntreeState extends State<ListEntree> {

  final TextEditingController nomprojet = TextEditingController();

  late Future<List<entree>> listeEntree;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    listeEntree = entreeService().getEntree() ;
  }

  int solde = 1000000;


  @override
  Widget build(BuildContext context) {
    print("liste des entrees");

    return Scaffold(
        drawer: const InkWellDrawer(),
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.green,
          elevation: 0,
          actions: const [Text("10000000",style: TextStyle(fontSize: 50),),],
        ),

        body: Center(
          child: FutureBuilder<List<entree>>(
            future: listeEntree,
            builder: ((context, snapshot){
              if(snapshot.hasData){
                return SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 15, right: 15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Toutes les entrées"),
                          Container(
                            margin: EdgeInsets.only(top: 50,left: 5, right: 5),
                            height: MediaQuery.of(context).size.height/1.3,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length, //nombre de projets dans la bd
                                itemBuilder: (context, index) {
                                  entree _entree = snapshot.data![index];
                                  return InkWell(
                                    onLongPress: () {
                                      //selection
                                    },
                                    onTap: () {

                                    },
                                    child:EntreePresentation(message: _entree.origine,montant: _entree.montant,date: _entree.date,),
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

    );
  }

  Future<void> modifEntree()async{

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
