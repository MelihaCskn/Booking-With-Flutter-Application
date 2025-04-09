
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rezerve/kurumsal.screens/ayarlar.kurumsal.dart';
import 'package:rezerve/services/auth-services.dart';

class KurumsalMenu extends StatefulWidget{
  @override
  State<KurumsalMenu> createState() => _KurumsalMenuState();
}

class _KurumsalMenuState extends State<KurumsalMenu> {
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.brown,
            ),
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container(
                      height: 100,
                         child: Image.asset("assets/images/saat2.jpg")),
                    SizedBox(height: 5,),
                    Text("Yerini AL",style: GoogleFonts.berkshireSwash(fontSize: 20,color: Colors.white),)
                  ],
                ),
              )),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar',),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>KurumsalAyarlar()));
            },
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Çıkış'),
              trailing: Icon(Icons.arrow_right),
              onTap: () async{
                final shouldPop=await showMyDialog();

              }

          ),


        ],
      ),
    );
    }
  Future<bool?> showMyDialog() =>showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Çıkış yapmak istediğinize emin misiniz?"),
          actions: [
            TextButton(
                child: Text('Evet'),
                onPressed: () =>
                  AuthServices().googleSignOut(context),

                ),


            TextButton(
                child: Text('Hayır'),
                onPressed: () =>Navigator.pop(context,true)

            ),
          ],
        );
      }
  );
}