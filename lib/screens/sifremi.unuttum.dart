import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rezerve/bireysel.screens/bireysel.giri%C5%9F.dart';
import 'package:rezerve/kurumsal.screens/kurumsal.kay%C4%B1t.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Şifre Sıfırlama Emaili Yollanmıştır")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BireyselGiris()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Kullanıcı Bulunamadı");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kayıtlı bir email bulunamadı")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/duvar2.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
              ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 70, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hoşgeldiniz :)",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, top: 40, bottom: 40),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lütfen Emailinizi Giriniz";
                                  }
                                },
                                onSaved: (value) {
                                  email = value!;
                                },
                                decoration:
                                    const InputDecoration(hintText: "Email"),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                });
                                resetPassword();
                              }
                            },
                            child: Text(
                              "Emaili Yolla",
                              style: TextStyle(color: Colors.brown),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BireyselGiris()));
                            },
                            child: const Text(
                              "Giriş",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bir hesabınız yok mu?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KurumsalKayit()));
                            },
                            child: const Text(
                              "Kaydol",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ))));
  }
}


