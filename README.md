# variacao-ativo-flutter

Projeto desenvolvido para avaliação técnica.
O projeto tem por objetivo realizar a busca via API REST de inndicadores de ativos da bolsa de investimentos brasileira.

# 1. Funcionalidades

1. Cunsulta de indicadores de ativo.
2. Consultar em gráfico a variação do ativo dos últimos 30 pregões.
3. Consulta da variação em D-1 em percentual.
4. Consulta da variação em em relação ai primeiro pregão em percentual.

# 2. Arquitetura

## 2.1 Design de arquitetura

- Clean Archtecture
- MVI

# 2.2 Package externos

- dio: Cliente HTTP.
- result_dart: Retorno múltiplo no formato Failure e Success.
- Mocktail: Para testes de unidade.
- GetIt: Injeção de dependências.
- fl_chart: Grafícos para apresentação de resultados.

# 3. Execução da aplicação

Seguir as orientações de preparação do ambiente em [Flutter.com](https://docs.flutter.dev/get-started/install)

Para executar em modo de desenvolvimento utilizar [Visual Studio Code] ou [Android Studio]
Para executar em modo release executar o seguinte comando no terminal na pasta raís do projeto:
`flutter run <platform> --release`

Ou pode-se optar por utilizar o pacote de instalação Android (não assinado) localizado na pasta `../release`
