import 'package:flutter/material.dart';
import 'package:variacao_ativo_flutter/src/core/di/core_di.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/home/home_view_model.dart';
import 'package:variacao_ativo_flutter/src/modules/home/ui/home_page.dart';

void main() {
  setupCoreDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "Variação de Ativo";
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff113A3B)),
      ),
      home: MyHomePage(
        title: title,
        state: getIt.get<HomeViewModel>().state,
        onEvent: getIt.get<HomeViewModel>().onEvent,
      ),
    );
  }
}
