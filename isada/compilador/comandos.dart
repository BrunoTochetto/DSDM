import 'erros.dart';
import 'funcoesAuxiliares.dart';
import 'variaveis.dart';
import './comandos/print.dart';

Map<String, Variavel> definicoesDoCodigo = {
  // Variáveis que o usuário pode mudar, configurações de sistema;
  "DEV": new Variavel(valor: false),
};

void definicao(String linha) {
  List<String> valores = linha.split(Sistema.definicao);

  var valor;

  if (verificarSeEhString(valores[1])) {

    printDev('definindo variável |${valores[0]}| como String', Cores.verde);
    valor = valores[1].split('"')[1].trim();
    
  } else if (int.tryParse(valores[1]) != null){

    printDev('definindo variável |${valores[0]}| como int', Cores.verde);
    valor = int.parse(valores[1]);

  } else if (valores[1].toString().toLowerCase() == "false" || valores[1].toString().toLowerCase() == "true"){
    printDev('definindo variável |${valores[0]}| como Booleano', Cores.verde);
    if (valores[1] == 'false') {
      valor = false;
    } else {
      valor = true;
    }
  }
  else {
    throw erroDeLinha('Não é possível definir esta variável');
  }

  Variavel definido = new Variavel(valor: valor);

  // print(valor);
  // print(valor.runtimeType);
  definicoesDoCodigo[valores[0].toString().trim()] = definido;
}

void printIsada(String linha) {
  String valorDoPrint = tirarValorDeFuncao(linha);
  List<String> valores = [];

  if (valorDoPrint.contains('+') || valorDoPrint.contains('*') || valorDoPrint.contains('/')) {
    valores = valorDoPrint.split('+');
    return printComValoresAdicionais(valores);

  } else {
    return printSemValoresAdicionais(valorDoPrint);
  }
}


