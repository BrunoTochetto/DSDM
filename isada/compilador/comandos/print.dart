import '../comandos.dart';
import '../variaveis.dart';
import '../funcoesAuxiliares.dart';
import '../erros.dart';

void printSemValoresAdicionais(String valor) {

  printDev('Entrou no printSemValoresAdicionasi', Cores.azul);

   dynamic stringFinal = stringParaValor(valor);

   print(stringFinal);

}

void printComValoresAdicionais(List<String> valores) {

  printDev('Entrou em print com valores adicionais', Cores.azul);
  var printFinal;
  for (dynamic valor in valores) {
    dynamic valorDeSaida;
    valor = valor.trim();

    printDev(valor);
    if (valor.contains('*') || valor.contains('/')) {
      valorDeSaida = _logicaContasAvancadas(valor);
    } else {
      valorDeSaida = stringParaValor(valor);
    }

    if (printFinal == null) {
      printFinal = valorDeSaida;
    } else {
      if (printFinal.runtimeType != valorDeSaida.runtimeType && printFinal.runtimeType == num && valorDeSaida.runtimeType == num) throw erroDeLinha('Não é possível concatenar dois tipos diferentes de dados.');

      printFinal += valorDeSaida;
    }

  }
  printDev('Resultado print:', Cores.verde);
  print(printFinal);
}






// Dinamic denovo pq pode retornar um int e uma string;
dynamic _logicaContasAvancadas(String valorCheio) {

  if (valorCheio.contains('*')) {
    List valores = valorCheio.split('*');

    var multiplicado = stringParaValor(valores[0]);
    var multiplicando = stringParaValor(valores[1]);

    return _multiplicacao([multiplicado, multiplicando]);
  } else if (valorCheio.contains('/')) {
    List valores = valorCheio.split('/');

    var dividendo = stringParaValor(valores[0]);
    var divisor = stringParaValor(valores[1]);

    if (divisor.runtimeType == String || dividendo.runtimeType == String) throw erroDeLinha('Não é possível dividir com Strings');
    return _divisao([dividendo, divisor]);
  }


}

dynamic _multiplicacao(List valores) {
  printDev('Lógica de multiplicação no print', Cores.azul);

  if (valores[1].runtimeType == String) throw erroDeLinha('Não é possível multiplicar algo por uma string');

  // if (valores[0].runtimeType == num)
  return (valores[0] * valores[1]);
}

num _divisao(List valores) {
  printDev('Lógica de divisão no print', Cores.azul);
  return valores[0] / valores[1];
}