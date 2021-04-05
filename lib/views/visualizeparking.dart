import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mps/services/database.dart';

class VisualizeParking extends StatefulWidget {
  final String value;
  VisualizeParking({Key key, @required this.value}) : super(key: key);

  @override
  _VisualizeParkingState createState() => _VisualizeParkingState(value: value);
}

class _VisualizeParkingState extends State<VisualizeParking> {
  String value;
  _VisualizeParkingState({this.value});
  var parking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Managing Parking System"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 140, vertical: 30),
              child: Center(
                child: Image(image: AssetImage('assets/Logo_Acron.png')),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('parqueaderos')
                    .doc(value) //ID OF DOCUMENT
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new CircularProgressIndicator();
                  }
                  parking = snapshot.data;
                  return new Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                          ),
                          Text(
                            parking["nombre"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                          Row(children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                            ),
                            Icon(Icons.star, size: 35.0, color: Colors.grey),
                            Text(
                              parking["puntaje"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey),
                            )
                          ]),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30)),
                          Text(
                            "Compartir parqueadero",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Icon(Icons.link)
                        ],
                      ),
                      Image.network(parking["imagen"], width: 350),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(parking["descripcion"]),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text(
                              "Precios: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0)),
                          Text("Carro: "),
                          Text(parking["precio"]["carro"].toString()),
                          Text(" min"),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0)),
                          Text("Moto: "),
                          Text(parking["precio"]["moto"].toString()),
                          Text(" min"),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20)),
                          Text("Direccion: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(parking["direccion"]),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text("Comentarios: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          for (var i in parking["comentarios"])
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            i["usuario"].toString(),
                                          ),
                                          Text(": "),
                                          Icon(Icons.star, color: Colors.grey),
                                          Text(
                                            i["estrellas"].toString(),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        i["comentario"].toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text("Como llegar: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}