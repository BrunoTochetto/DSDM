import 'variaveis.dart';
import 'funcoesAuxiliares.dart';

void printDeErroBonito(e) {
  String barras = Cores.texto('=' * e.length, Cores.vermelho);
  
  print(barras);
  print(Cores.texto(e, Cores.amarelo));
  print(barras);

}

Exception erroDeLinha(String erro) {
  return new Exception('Erro na linha ${Sistema.numeroLinha}: ' + erro);
}