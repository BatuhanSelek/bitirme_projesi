// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bitirme_projesi/blocs/sepet.dart';
import 'package:bitirme_projesi/models/yemek_model.dart';
import 'package:bitirme_projesi/views/sepet_sayfa.dart';

class DetaySayfa extends StatefulWidget {
  DetaySayfa({
    Key? key,
    required this.yemek,
    required this.kullaniciAdi,
  }) : super(key: key);
  final YemekModel yemek;
  final String kullaniciAdi;

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int adet = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber[900],
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Ürün Detay',
            style:
                GoogleFonts.playfairDisplay(fontSize: 30, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SepetSayfa()));
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Yemek Resmi
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}",
                fit: BoxFit.cover,
                height: 250,
              ),
            ),

            const SizedBox(height: 16),
            // Yemek Bilgileri
            Text(
              textAlign: TextAlign.center,
              "${widget.yemek.yemek_fiyat} ₺",
              style: const TextStyle(
                fontSize: 50,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              textAlign: TextAlign.center,
              widget.yemek.yemek_adi,
              style: GoogleFonts.playfairDisplay(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Adet Seçimi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Adet Seç:",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (adet > 1) {
                          setState(() {
                            adet--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.amber[900],
                        size: 50,
                      ),
                    ),
                    Text(
                      adet.toString(),
                      style: const TextStyle(fontSize: 50),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          adet++;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.amber[900],
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "25-35 dk",
                    style: GoogleFonts.playfairDisplay(),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Ücretsiz Teslimat",
                    style: GoogleFonts.playfairDisplay(),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "İndirim",
                    style: GoogleFonts.playfairDisplay(),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            // Sepete Ekle Butonu
            ElevatedButton.icon(
              onPressed: () {
                context.read<SepetCubit>().sepeteYemekEkle(
                    yemekAdi: widget.yemek.yemek_adi,
                    yemekResimAdi: widget.yemek.yemek_resim_adi,
                    yemekFiyat: int.parse(widget.yemek.yemek_fiyat),
                    yemekSiparisAdet: adet,
                    kullaniciAdi: widget.kullaniciAdi);
              },
              icon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 35,
              ),
              label: Text(
                "Sepete Ekle",
                style: GoogleFonts.playfairDisplay(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.amber[900]),
            ),
          ],
        ),
      ),
    );
  }
}
