import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Masa {
  final String masaId;
  final String masaNo;
  final String SalonId;
  final bool Doluluk;
  final String docId;
  Masa({
    required this.masaId,
    required this.masaNo,
    required this.SalonId,
    required this.Doluluk,
    required this.docId,
  });

  static Masa fromJson(Map<String, dynamic> json) => Masa(
      masaId: json['MasaId'],
      masaNo: json['MasaNo'],
      SalonId: json['SalonId'],
      Doluluk: json['Doluluk'],
      docId: json['docId']);

  Map<String, dynamic> toMap() {
    return {
      'MasaId': masaId,
      'SalonId': SalonId,
      'MasaNo': masaNo,
      'Doluluk': Doluluk,
      'docId': docId
    };
  }
}