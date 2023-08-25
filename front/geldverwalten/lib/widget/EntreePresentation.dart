import 'package:flutter/material.dart';

class EntreePresentation extends StatelessWidget {

  final int montant;
  final String message;
  final String date;


  EntreePresentation({
    required this.montant,
    required this.message,
    required this.date
  });


  int total = 0;
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
                date as String,
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
                                child: SingleChildScrollView(child:  Text("Origine: $message    Montant: $montant"),scrollDirection: Axis.horizontal,)
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
              child: Text("   Total : $montant",
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