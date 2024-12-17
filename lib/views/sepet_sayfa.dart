import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SepetSayfa extends StatefulWidget {
  @override
  _SepetSayfasiState createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfa> {
  List<dynamic> sepetYemekleri = [];
  double toplamTutar = 0;

  // Sepetteki yemekleri getiren fonksiyon
  Future<void> sepetYemekleriGetir() async {
    final url = Uri.parse(
        "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");

    final response = await http.post(url, body: {"kullanici_adi": "Batuhan"});

    print("Sunucudan Dönen Yanıt: ${response.body}"); // Gelen yanıtı yazdır

    if (response.statusCode == 200) {
      try {
        // JSON formatında olup olmadığını kontrol et
        final data = json.decode(response.body);

        // JSON düzgünse devam et
        if (data != null && data["sepet_yemekler"] != null) {
          setState(() {
            sepetYemekleri =
                List<Map<String, dynamic>>.from(data["sepet_yemekler"]);
            toplamTutarHesapla();
          });
        } else {
          // Sepet boş veya geçersiz veri
          setState(() {
            sepetYemekleri = [];
            toplamTutar = 0;
          });
          print("Sepet boş ya da geçersiz veri döndü.");
        }
      } catch (e) {
        // JSON değilse hata yönetimi
        print("Hata: JSON formatında veri dönmedi. Detay: $e");
        setState(() {
          sepetYemekleri = [];
          toplamTutar = 0;
        });
      }
    } else {
      // Sunucu hatası durumunda
      print("HTTP Hatası: ${response.statusCode}");
      setState(() {
        sepetYemekleri = [];
        toplamTutar = 0;
      });
    }
  }

  // Toplam tutarı hesaplama
  void toplamTutarHesapla() {
    double toplam = 0;

    if (sepetYemekleri.isNotEmpty) {
      for (var yemek in sepetYemekleri) {
        toplam += int.parse(yemek["yemek_fiyat"]) *
            int.parse(yemek["yemek_siparis_adet"]);
      }
    }

    setState(() {
      toplamTutar = toplam;
    });
  }

  // Sepetten yemek silen fonksiyon
  Future<void> sepettenYemekSil(String yemekId) async {
    final url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    final response = await http.post(url,
        body: {"sepet_yemek_id": yemekId, "kullanici_adi": "Batuhan"});

    if (response.statusCode == 200) {
      print("Yemek silindi: $yemekId");
      await sepetYemekleriGetir();
    } else {
      print("Yemek silinirken hata oluştu.");
    }
  }

  @override
  void initState() {
    super.initState();
    sepetYemekleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber[900],
          title: Text(
            "Sepetim",
            style: GoogleFonts.playfairDisplay(fontSize: 30),
          )),
      body: sepetYemekleri.isEmpty
          ? Center(
              child: Text(
                "Sepetinizde hiç ürün yok!",
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetYemekleri.length,
                    itemBuilder: (context, index) {
                      var yemek = sepetYemekleri[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            // Yemek resmi
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              child: Image.network(
                                "http://kasimadalan.pe.hu/yemekler/resimler/${yemek['yemek_resim_adi']}",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Yemek bilgileri
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      yemek["yemek_adi"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        "Adet: ${yemek['yemek_siparis_adet']}"),
                                    Text(
                                      "Fiyat: ${yemek['yemek_fiyat']} ₺",
                                      style: const TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Silme butonu
                            IconButton(
                              icon:
                                  Icon(Icons.delete, color: Colors.amber[900]),
                              onPressed: () =>
                                  sepettenYemekSil(yemek["sepet_yemek_id"]),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Toplam tutar alanı
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Toplam Tutar:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$toplamTutar ₺",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
