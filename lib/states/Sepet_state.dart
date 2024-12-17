abstract class SepetState {}

class SepetInitial extends SepetState {}

class SepetYukleniyor extends SepetState {}

class SepetEklemeBasarili extends SepetState {}

class SepetEklemeHata extends SepetState {
  final String hataMesaji;
  SepetEklemeHata(this.hataMesaji);
}
