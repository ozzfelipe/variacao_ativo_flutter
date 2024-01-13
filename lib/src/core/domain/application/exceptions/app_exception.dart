abstract class AppException implements Exception {
  final String message;

  AppException(
      {this.message =
          "Um erro inesperado aconteceu, verifique sua conexão ou tente novamente mais tarde"});
}

class UnexpectedException extends AppException {
  UnexpectedException({super.message});

  @override
  String get message =>
      'Aconteceu um erro inesperado, verifique sua internet ou tente novamente mais tarde';
}

class ArgumentsException extends AppException {
  @override
  String get message => 'Pramentros inválido';
}

class StockNotFoundException extends AppException {
  @override
  String get message =>
      'Ativo não encontrado, verique o texto inserido novamente';
}

class DataNotAvailableException extends AppException {
  @override
  String get message => 'Dados para o ativo selecionado não encontrado';
}
