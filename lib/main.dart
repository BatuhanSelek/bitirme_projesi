import 'package:bitirme_projesi/blocs/anasayfa.dart';
import 'package:bitirme_projesi/blocs/sepet.dart';

import 'package:bitirme_projesi/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AnasayfaCubit(),
        ),
        BlocProvider(
          create: (context) => SepetCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Yemek Sipariş Uygulaması',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}
