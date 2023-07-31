import 'package:flutter/material.dart';


class InkWellDrawer extends StatelessWidget {
  const InkWellDrawer({super.key});

  @override
  Widget build (BuildContext context) {
    return Drawer(
      backgroundColor:Colors.orange,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 2.0,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: const AssetImage("images/gb1.jpg"),//id.photoprofil
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                      child: InkWell(
                        onTap: (){ },
                      ),
                    ),
                  ),
                  const Text("utilisateurActuel.prenoms", style: TextStyle(color: Colors.white, fontSize: 25.0),)
                ],
              )),
          CustomListTile(Icons.person_outlined, 'Mon profile', ()=>{
            Navigator.pop(context),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Text("mettre le chemin a la place de ''const Text('...')'' "))
            )
          }),
          CustomListTile(Icons.shopping_cart_outlined, 'Mes commandes', ()=>{
            Navigator.pop(context),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Text("mettre le chemin a la place de ''const Text('...')'' "))
            )
          }),
          CustomListTile(Icons.logout, 'Se déconnecter', () async {

            await showDialog(context: context,
                barrierDismissible: false,
                builder: (BuildContext context){
                  return SimpleDialog(
                    contentPadding: const EdgeInsets.all(10.0),
                    children: [
                      const Text("VOULEZ VOUS VRAIMENT VOUS DECONNECTER ??",textAlign: TextAlign.center),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: const Text("Annuler",style: TextStyle(fontSize: 12),)
                          ),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Text("mettre le chemin a la place de ''const Text('...')'' "))
                            );
                          }, child: const Text("Me déconnecter",style: TextStyle(fontSize: 12),)
                          )
                        ],
                      )
                    ],
                  );
                });

          }),
          CustomListTile(Icons.shopping_cart_outlined, 'A propos de notre restaurant', ()=>{
            Navigator.pop(context),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Text("mettre le chemin a la place de ''const Text('...')'' "))
            )
          }),

        ],
      ),
    );
  }





}
class CustomListTile extends StatelessWidget{
  final IconData icon;
  final String text;
  //final VoidCallback onTap;
  final void Function() onTap;
  const CustomListTile(this.icon, this.text, this.onTap, {super.key});
  @override
  Widget build(BuildContext context){
//ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 8.0, 0),
      child:Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white54))
        ),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Icon(icon,color: Colors.white70,),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(text, style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70
                      ),),
                    ],),
                  ],)
            )
        ),
      ),
    );
  }



}