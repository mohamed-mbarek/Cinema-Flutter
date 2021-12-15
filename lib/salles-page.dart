import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:projet_cinema/GlobalData.dart';
class SallePage extends StatefulWidget {

  dynamic cinema;

  SallePage(this.cinema);
  @override
  _SallePageState createState() => _SallePageState();
}

class _SallePageState extends State<SallePage> {

  late List listSalle;
  late List listProjection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salle de ${widget.cinema['nom']}'),),
      body: Center(
            child: this.listSalle==null?CircularProgressIndicator():
            ListView.builder(
                itemCount: this.listSalle==null?0 :this.listSalle.length,
                itemBuilder:(context,index){
                  return Card(
                    color: Colors.cyan,
                    child:Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: Colors.white,
                              child: Text(this.listSalle[index]['nom'] ,style: TextStyle(color: Colors.black),),
                              onPressed:(){
                                loadProjection(this.listSalle[index]);
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Image.network(GlobalData.host+/)
                          ],
                        )
                      ],
                    )
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
    loadSalles();
  }

  void loadSalles() {
    String url = "http://172.29.32.1:8080/salles/getSalle/${widget.cinema['id']}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.listSalle = json.decode(resp.body);
      });
    }).catchError((err) {
      print(err);
    });
  }

  void loadProjection(salle) {
    String url=GlobalData.host+"/projectionFilm/ListFilm/${salle['id']}";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
      this.listProjection= json.decode(resp.body);
      });
    }).catchError((err){
      print(err);
    });  }
}