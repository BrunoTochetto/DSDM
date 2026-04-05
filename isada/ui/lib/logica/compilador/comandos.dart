import 'funcoesAuxiliares.dart';
import 'variaveis.dart';
import './comandos/print.dart';

Map<String, Variavel> variaveisDoCodigo = {};

void definicao(String linha) {
  List<String> valores = linha.split(Sistema.definicao);

  // o problema disso é a falta de output log na definição...
  var valor = variaveisComValoresAdicionais(valores[1]);

  Variavel definido = Variavel(valor: valor);

  printDev('Definido variável como ${definido.tipo}, com valor de |${definido.valor}|');
  variaveisDoCodigo[valores[0].toString().trim()] = definido;
}

void printIsada(String linha) {
  String valorDoPrint = tirarValorDeFuncao(linha);
  printComValoresAdicionais(valorDoPrint);
  
  return;
}


