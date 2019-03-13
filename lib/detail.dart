import 'package:flutter/material.dart';
import 'package:pokeflutter/pokemon.dart';

class Detail extends StatelessWidget{
  final Pokemon pokemon;

  Detail({this.pokemon});

  bodyWidget(BuildContext context)=>Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width-20,
        left: 10.0,
        top: MediaQuery.of(context).size.height*0.1,
        child: Card(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 70.0,
                ),
                Text(pokemon.name,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                Text("Altura: ${pokemon.height}"),
                Text("Peso: ${pokemon.weight}"),
                Text("Tipo",style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pokemon.type.map((t) => FilterChip(
                      backgroundColor: Colors.amber,
                      label: Text(
                        t,
                        style: TextStyle(color: Colors.white),),
                      onSelected: (b) {}))
                      .toList(),
                ),
                Text("Debilidad",style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pokemon.weaknesses.map((t) => FilterChip(
                      backgroundColor: Colors.red,
                      label: Text(
                        t,
                        style: TextStyle(color: Colors.white),
                      ),
                      onSelected: (b) {}))
                      .toList(),
                ),
                Text("Evoluciones",style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pokemon.nextEvolution?.map((n) => FilterChip(
                      backgroundColor: Colors.lightBlueAccent,
                      label: Text(
                          n.name,
                          style: TextStyle(color: Colors.white),
                      ),
                      onSelected: (b) {}))?.toList()??[FilterChip(
                    backgroundColor: Colors.lightBlueAccent,
                    label: Text(
                      "Ultima Evolucion",
                      style: TextStyle(color: Colors.white),
                    ),onSelected: (b) {})],
                )
              ],
            ),
          ),
      ),


      Align(
        alignment: Alignment.topCenter,
        child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 160.0,
              width: 160.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
            )),
      )
    ],
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        title: Text(pokemon.num),
      ),
      body: bodyWidget(context),
    );
  }
}