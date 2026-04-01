import 'variaveis.dart';

Exception erroDeLinha(String erro) {
  return new FormatException('Erro na linha ${Sistema.numeroLinha}: ' + erro);
}