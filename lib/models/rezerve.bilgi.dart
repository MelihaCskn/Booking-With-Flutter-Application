

class RezerveBilgi {
  final String rezervdeId;
  final String kafe_isim;
  final String masa_kisi_sayisi;
  final String resim;
  final String Salon;

  RezerveBilgi(
      {required this.rezervdeId,
        required this.kafe_isim,
        required this.masa_kisi_sayisi,
        required this.resim,
        required this.Salon,
       });

  static RezerveBilgi fromJson(Map<String, dynamic> json) => RezerveBilgi(
    rezervdeId: json['RezerveId'],
    kafe_isim: json['Kafe İsim'],
    masa_kisi_sayisi: json['Masa kisi Sayısı'],
    resim: json['Resim'],
    Salon: json['Salon'],
  );

  Map<String, dynamic> toMap() {
    return {
      'FilmId': rezervdeId,
      'FilmAdi': kafe_isim,
      'Bilgi': masa_kisi_sayisi,
      'resim': resim,
      'Salon': Salon,

    };
  }
}