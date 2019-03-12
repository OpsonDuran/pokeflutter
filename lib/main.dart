import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeflutter/pokemon.dart';
import 'package:pokeflutter/detail.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
  title: "Poke Flutter",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Center(
            child: Text("Pokedex",
              style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.redAccent
      ),
      body: pokeHub == null?Center(child: CircularProgressIndicator(),):
      GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke)=> Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=> Detail(
                        pokemon: poke,
                      )));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                  children: <Widget>[
                    Text(
                      poke.num,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:NetworkImage(poke.img) )
                      ),
                    ),
                    Text(
                      poke.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,

                      ) )
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}