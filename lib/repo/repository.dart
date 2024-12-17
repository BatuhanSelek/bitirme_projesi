import 'dart:convert';

import 'package:bitirme_projesi/models/yemek_cevap.dart';
import 'package:bitirme_projesi/models/yemek_model.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository {
  List<YemekModel> parseYemekler(String cevap) {
    return YemekCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<YemekModel>> yemekleriGetir() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }
  
}
