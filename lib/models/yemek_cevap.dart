// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bitirme_projesi/models/yemek_model.dart';

class YemekCevap {
  List<YemekModel> yemekler;
  int success;
  YemekCevap({
    required this.yemekler,
    required this.success,
  });

  factory YemekCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    int success = json["success"] as int;

    var yemekler = jsonArray
        .map((jsonArrayNesnesi) => YemekModel.fromJson(jsonArrayNesnesi))
        .toList();

    return YemekCevap(yemekler: yemekler, success: success);
  }
}
