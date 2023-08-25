import 'package:flutter/material.dart';
import 'package:geldverwalten/widget/Boutton.dart';

class ProjetInfo extends StatefulWidget {
  const ProjetInfo({super.key, required this.title});


  final String title;

  @override
  State<ProjetInfo> createState() => _ProjetInfoState();
}

class _ProjetInfoState extends State<ProjetInfo> {

  final TextEditingController raison = TextEditingController();
  final TextEditingController montant = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded),onPressed: (){Navigator.pop(context);},),
          actions: const [Text("10000000",style: TextStyle(fontSize: 50),),],
          //backgroundColor: Colors.green,
          elevation: 0,
        ),

        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/7,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, //nombre de projets dans la bd
                    itemBuilder: (context, index) {
                      return InkWell(
                          onLongPress: () {
                            //selection
                          },
                          onTap: () {

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
                            child: Text("ddd"),
                          )
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 15, right: 15),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Nom du projet"),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 15, right: 15),
                      height: MediaQuery.of(context).size.height/1.8,
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
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("aaaa"),Text("0000")],),
                                )
                            );
                          }),
                    ),
                  ],
                ),
              ),
              buildButton("Nouvelle sortie", Colors.green, () { newSortie(); }),
            ],
          )
        )

    );
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
                  buildButton("Creer", Colors.green, () { }),

                ],
              )
            ],
          );
        });
  }
}
