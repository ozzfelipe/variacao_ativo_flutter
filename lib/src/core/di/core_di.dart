import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/di/home_di.dart';

GetIt getIt = GetIt.instance;

void setupCoreDi() {
  getIt.registerFactory<Dio>(() => Dio());
  setUpHomeDi();
}
