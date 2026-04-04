import 'funcoesAuxiliares.dart';
import 'variaveis.dart';
import './comandos/print.dart';

Map<String, Variavel> variaveisDoCodigo = {
  // Variáveis que o usuário pode mudar, configurações de sistema;
  "DEV": new Variavel(valor: false),
};

void definicao(String linha) {
  List<String> valores = linha.split(Sistema.definicao);
  // o problema disso é a falta de output log na definição...
  var valor = variaveisComValoresAdicionais(valores[1]);

  // if (verificarSeEhString(valores[1])) {

  //   printDev('definindo variável |${valores[0]}| como String', Cores.verde);
  //   valor = valores[1].split('"')[1].trim();
    
  // } else if (int.tryParse(valores[1]) != null){

  //   printDev('definindo variável |${valores[0]}| como int', Cores.verde);
  //   valor = int.parse(valores[1]);

  // } else if (valores[1].toString().toLowerCase() == "false" || valores[1].toString().toLowerCase() == "true"){
  //   printDev('definindo variável |${valores[0]}| como Booleano', Cores.verde);
  //   if (valores[1] == 'false') {
  //     valor = false;
  //   } else {
  //     valor = true;
  //   }
  // }
  // else {
  //   throw erroDeLinha('Não é possível definir esta variável');
  // }

  Variavel definido = new Variavel(valor: valor);


  printDev('Definido variável como ${definido.tipo}');
  variaveisDoCodigo[valores[0].toString().trim()] = definido;
}

void printIsada(String linha) {
  String valorDoPrint = tirarValorDeFuncao(linha);

  if (valorDoPrint.contains('+') || valorDoPrint.contains('*') || valorDoPrint.contains('/')) {
    return printComValoresAdicionais(valorDoPrint);

  } else {
    return printSemValoresAdicionais(valorDoPrint);
  }
}


