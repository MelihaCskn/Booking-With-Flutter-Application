

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rezerve/firebase_options.dart';
import 'package:rezerve/screens/ilksayfa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(


      debugShowCheckedModeBanner: false,
      home: IlkBolum(),
    );
  }
}

