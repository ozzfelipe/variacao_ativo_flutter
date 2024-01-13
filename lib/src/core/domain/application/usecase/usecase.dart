import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';

abstract class Usecase<Input extends Object, Output extends Object> {
  Future<Result<Output, AppException>> call({required Input params});
}

abstract class UsecaseWithoutParams<Output extends Object> {
  Future<Result<Output, AppException>> call();
}
