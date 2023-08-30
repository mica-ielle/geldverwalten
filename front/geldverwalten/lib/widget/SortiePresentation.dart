import 'package:flutter/material.dart';
import 'package:geldverwalten/Model/sortieService.dart';
import 'package:geldverwalten/widget/EntreePresentation.dart';

class SortiePresentation extends StatefulWidget {
  final int idProjet;
  final String nomProjet;

  const SortiePresentation({required this.idProjet,required this.nomProjet});


  @override
  State<SortiePresentation> createState() => _SortiePresentationState();
}

class _SortiePresentationState extends State<SortiePresentation> {

  final TextEditingController nomprojet = TextEditingController();

  late Future<List<sortie>> listeSortie;
  int somProjet = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listeSortie = sortieService().getSortieProjet(widget.idProjet) ;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 10,),
        Align(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.nomProjet,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.green
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.start,
              )
          ),
          alignment: Alignment.topLeft,
        ),
        SizedBox(height: 10,),

        FutureBuilder<List<sortie>>(
          future: listeSortie,
          builder: ((context, snapshot){
            if(snapshot.hasData){
              return  Container(
                padding: const EdgeInsets.only(top: 10,left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 50,
                        color: Colors.black12)
                  ],
                ),
                height: MediaQuery.of(context).size.width/1.5,
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
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 10,),
                              Align(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                      _sortie.date,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                    )
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.only(top: 10,left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 50,
                                        color: Colors.black12)
                                  ],
                                ),
                                height: MediaQuery.of(context).size.width/5.5,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1, //nombre de projets dans la bd
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onLongPress: () {
                                          //selection
                                        },
                                        onTap: () {

                                        },
                                        child:Align(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(Icons.eco_outlined,size: 24,),
                                                SizedBox(
                                                  height: 20,
                                                  width: MediaQuery.of(context).size.width / 1.4,
                                                  child: Center(
                                                      child: SingleChildScrollView(child:  Text("Raison: ${_sortie.message}    Montant: ${_sortie.montant}"),scrollDirection: Axis.horizontal,)
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                      );
                                    }),
                              ),

                              SizedBox(height: 10,),
                              Align(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text("   Total : ?",
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                    )
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(height: 20,),
                              Container(
                                height: 1,
                                color: Colors.black38,
                              )
                            ],
                          )
                      );
                    }),
              );
            }else if(snapshot.hasError){

            }

            return CircularProgressIndicator();
          }),
        ),

        SizedBox(height: 10,),
        Align(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text("   Total Projet : $somProjet",
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.start,
              )
          ),
          alignment: Alignment.topLeft,
        ),
        SizedBox(height: 20,),
        Container(
          height: 1,
          color: Colors.black38,
        )
      ],
    );
  }
}