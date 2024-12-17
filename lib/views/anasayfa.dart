import 'package:bitirme_projesi/blocs/anasayfa.dart';
import 'package:bitirme_projesi/models/yemek_model.dart';
import 'package:bitirme_projesi/views/detay_Sayfa.dart';
import 'package:bitirme_projesi/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  List<YemekModel> favoriler = [];

  void favoriEkleCikar(YemekModel yemek) {
    setState(() {
      // Eğer yemek zaten favorilerdeyse çıkar, yoksa ekle
      if (favoriler.any((element) => element.yemek_id == yemek.yemek_id)) {
        favoriler.removeWhere((element) => element.yemek_id == yemek.yemek_id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${yemek.yemek_adi} favorilerden çıkarıldı!"),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        favoriler.add(yemek);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${yemek.yemek_adi} favorilere eklendi!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber[900],
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Chefood',
            style:
                GoogleFonts.playfairDisplay(fontSize: 35, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_basket),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SepetSayfa()));
              })
        ],
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 45,
        ),
      ),
      body: BlocBuilder<AnasayfaCubit, List<YemekModel>>(
        builder: (context, yemeklerListesi) {
          if (yemeklerListesi.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: yemeklerListesi.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Her satırda 2 kart
                  crossAxisSpacing: 8.0, // Kartlar arası yatay boşluk
                  mainAxisSpacing: 8.0, // Kartlar arası dikey boşluk
                  childAspectRatio: 3 / 4, // Kartların genişlik/yükseklik oranı
                ),
                itemBuilder: (context, index) {
                  final yemek = yemeklerListesi[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  yemek.yemek_adi,
                                  style: GoogleFonts.playfairDisplay(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${yemek.yemek_fiyat} ₺",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  favoriler.contains(yemek)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.amber[900],
                                ),
                                onPressed: () {
                                  favoriEkleCikar(yemek);
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetaySayfa(
                                              yemek: yemek,
                                              kullaniciAdi: "Batuhan")));
                                },
                                icon: Icon(
                                  Icons.arrow_circle_right,
                                  color: Colors.amber[900],
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
