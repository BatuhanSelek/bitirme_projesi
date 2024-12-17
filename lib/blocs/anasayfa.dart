import 'package:bitirme_projesi/models/yemek_model.dart';
import 'package:bitirme_projesi/repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<YemekModel>> {
  AnasayfaCubit():super(<YemekModel>[]);
   var yrepo = YemeklerDaoRepository();

    Future<void> yemekleriGetir() async {
    var liste = await yrepo.yemekleriGetir();
    emit(liste);
  }
}