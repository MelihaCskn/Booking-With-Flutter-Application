import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rezerve/bireysel.screens/bireysel.giri%C5%9F.dart';
import 'package:rezerve/kurumsal.screens/anasayfa.kurumsal.dart';
import '../bireysel.screens/anasayfa.bireysel.dart';
import '../kurumsal.screens/kurumsal.giris.dart';


class AuthServices {
  late String email, sifre, isim,profilImages,kurumProfilImages,kurum_isim;
  final bauth = FirebaseAuth.instance;
  final kauth = FirebaseAuth.instance;
  final singularUserCollection = FirebaseFirestore.instance.collection("singular users");
  final corporateUserCollection = FirebaseFirestore.instance.collection("corporate users");
  final GoogleSignIn gUser = GoogleSignIn();

  Future<void> BireyselKayitOl(BuildContext context,
      {required String email,
        required String password,
        required String isim,
        required String telno,required String profilImages}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await bauth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await BireyselKullaniciKayit(
            email: email, password: password, isim: isim, telno: telno,profilImages:profilImages);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Kullanıcı Başarıyla Kaydedildi,giriş sayfasına yönlendiriliyorsunuz")),
        );
        navigator.push(MaterialPageRoute(builder: (context) => const BireyselGiris()));
      }
    } on FirebaseAuthException {}
  }

  Future<void> KurumsalKayitOl(BuildContext context,
      {required String email,
        required String password,
        required String kurum_isim,
        required String telno, required String kurumProfilImages}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await kauth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await KurumsalKullaniciKayit(
            email: email, password: password, kurum_isim: kurum_isim, telno: telno, kurumProfilImages: kurumProfilImages);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Kullanıcı Başarıyla Kaydedildi,giriş sayfasına yönlendiriliyorsunuz")),
        );
        navigator.push(MaterialPageRoute(builder: (context) => const KurumsalGiris()));
      }
    } on FirebaseAuthException {}
  }

  Future<void> BireyselGirisYap(BuildContext context,
      {required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential buserCredential = await bauth
          .signInWithEmailAndPassword(email: email, password: password);
      if (buserCredential.user != null) {
        navigator.push(MaterialPageRoute(builder: (context) => BireyselAnasayfa()));
      }
    } catch (e) {
      print('Giriş işlemi başarısız oldu: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text(
                'Giriş işlemi başarısız oldu. Lütfen geçerli bir e-posta ve şifre girin.'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  Future<void> KurumsalGirisYap(BuildContext context,
      {required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential kuserCredential = await kauth
          .signInWithEmailAndPassword(email: email, password: password);
      if (kuserCredential.user != null) {
        navigator.push(MaterialPageRoute(builder: (context) => KurumsalAnasayfa()));
      }
    } catch (e) {
      print('Giriş işlemi başarısız oldu: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text(
                'Giriş işlemi başarısız oldu. Lütfen geçerli bir e-posta ve şifre girin.'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> KurumsalKullaniciKayit(
      {required String email,
        required String password,
        required String telno,required String kurumProfilImages, required String kurum_isim}) async {
    await corporateUserCollection
        .doc(kauth.currentUser!.email)
        .set({"isim": kurum_isim, "email": email, "sifre": password, "telno": telno,"kurumProfilImages":kurumProfilImages});
  }
  Future<void> BireyselKullaniciKayit(
      {required String email,
        required String password,
        required String isim,
        required String telno, required String profilImages}) async {
    await singularUserCollection
        .doc(bauth.currentUser!.email)
        .set({"isim": isim, "email": email, "sifre": password, "telno": telno,"profilImages":profilImages});
  }

  Future<User?> GoogleGirisYap(BuildContext context) async {
    final navigator = Navigator.of(context);
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    final userCredential = await bauth.signInWithCredential(credential);
    navigator.push(MaterialPageRoute(builder: (context) => KurumsalAnasayfa()));
    return userCredential.user;
  }

  googleSignOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    bauth.signOut();
    await gUser.signOut();
    navigator.push(MaterialPageRoute(builder: (context) => BireyselGiris()));
  }
}