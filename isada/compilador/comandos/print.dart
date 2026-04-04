import '../variaveis.dart';
import '../funcoesAuxiliares.dart';


void printSemValoresAdicionais(String valor) {

  printDev('Entrou no printSemValoresAdicionas', Cores.azul);

   dynamic stringFinal = stringParaValor(valor);
   print(stringFinal);

}

void printComValoresAdicionais(String valor) {

  printDev('Entrou em print com valores adicionais', Cores.azul);
  dynamic printFinal = variaveisComValoresAdicionais(valor);
  printDev('Resultado print:', Cores.verde);
  print(printFinal);
}

