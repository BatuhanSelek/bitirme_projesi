import 'package:bitirme_projesi/states/Sepet_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class SepetCubit extends Cubit<SepetState> {
  SepetCubit() : super(SepetInitial());

  Future<void> sepeteYemekEkle({
    required String yemekAdi,
    required String yemekResimAdi,
    required int yemekFiyat,
    required int yemekSiparisAdet,
    required String kullaniciAdi,
  }) async {
    emit(SepetYukleniyor());

    try {
      var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";

      var data = {
        "yemek_adi": yemekAdi,
        "yemek_resim_adi": yemekResimAdi,
        "yemek_fiyat": yemekFiyat.toString(), // Fiyatı String'e çeviriyoruz.
        "yemek_siparis_adet": yemekSiparisAdet,
        "kullanici_adi": kullaniciAdi,
      };

      Dio dio = Dio();
      Response response = await dio.post(url, data: FormData.fromMap(data));

      if (response.statusCode == 200) {
        emit(SepetEklemeBasarili());
      } else {
        emit(SepetEklemeHata("Sepete ekleme başarısız."));
      }
    } catch (e) {
      emit(SepetEklemeHata("Hata oluştu: ${e.toString()}"));
    }
  }
}
