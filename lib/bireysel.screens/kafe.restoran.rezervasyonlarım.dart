import 'package:flutter/material.dart';

class Rezervasyonlarim extends StatefulWidget {
  @override
  State<Rezervasyonlarim> createState() => _RezervasyonlarimState();
}

class _RezervasyonlarimState extends State<Rezervasyonlarim> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pxfuel.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [IconButton(onPressed:(){}, icon: Icon(Icons.search))],
          ),
        ));
  }
}