import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:projet_cinema/Cinemas-page.dart';
import 'package:projet_cinema/GlobalData.dart';

class VillePage extends StatefulWidget {
  @override
  _VillePageState createState() => _VillePageState();
}

class _VillePageState extends State<VillePage> {
  late List listVilles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Villes'),
      ),
      body: Center(
        child: this.listVilles==null?CircularProgressIndicator():
            ListView.builder(
                itemCount: (this.listVilles==null)?0 :this.listVilles.length,
                itemBuilder:(context,index){
                  return Card(
                    color: Colors.cyan,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text(this.listVilles[index]['nom'] ,style: TextStyle(color: Colors.black),),
                      onPressed:(){
                        Navigator.push(context ,
                        MaterialPageRoute(
                          builder : (context)=> new CinemasPage(this.listVilles[index])));
                      },
                    ),
                  ),
                  );
                }
            )
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVille();
  }
  void loadVille(){
    //String url="http://192.168.1.191:8080/villes/all";
    String url=GlobalData.host+"/villes/all";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.listVilles=json.decode(resp.body);
      });
    }).catchError((err){
      print(err);
    });
  }
}
