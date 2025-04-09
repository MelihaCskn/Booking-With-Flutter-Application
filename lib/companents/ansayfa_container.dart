import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnasayfaContainer extends StatelessWidget{
  late String assetsName;
  late String textName;

  void Function()? ontap;
  AnasayfaContainer({required this.assetsName, required this.textName, required this.ontap});
  @override
  Widget build(BuildContext context) {
   return
     Container(
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
       child: TextButton(
           onPressed:ontap,
           child: Column(children: [
             CircleAvatar(
               radius: 80,
               backgroundColor: Colors.white,
               backgroundImage: AssetImage('assets/images/$assetsName'),
             ),
             SizedBox(
               height: 5,
             ),
             Text(
               "$textName",
               style: GoogleFonts.ptSerif(
                   fontSize: 15,
                   fontWeight: FontWeight.bold,
                   color: Colors.black),
             ),

           ])),
     );
   }
  }

