import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:projet_cinema/salles-page.dart';
class CinemasPage extends StatefulWidget {

  dynamic ville;
  CinemasPage(this.ville);
  @override
  _CinemasPageState createState() => _CinemasPageState();
}

class _CinemasPageState extends State<CinemasPage> {

  late List listCinemas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cinemas de ${widget.ville['nom']}'),),
      body: Center(
            child: this.listCinemas==null?CircularProgressIndicator():
            ListView.builder(
                itemCount: (this.listCinemas==null)?0 :this.listCinemas.length,
                itemBuilder:(context,index){
                  return Card(
                    color: Colors.cyan,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(this.listCinemas[index]['nom'] ,style: TextStyle(color: Colors.black),),
                        onPressed:(){
                          Navigator.push(context ,
                              MaterialPageRoute(
                                  builder : (context)=> new SallePage(this.listCinemas[index])));
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
    loadCinema();
  }

  void loadCinema() {
    String url = "http://172.29.32.1:8080/cinemas/getCinemas/${widget
        .ville['id']}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.listCinemas = json.decode(resp.body);
      });
    }).catchError((err) {
      print(err);
    });
  }
}