import 'erros.dart';
import 'funcoesAuxiliares.dart';
import 'variaveis.dart';

Map<String, Variavel> definicoesDoCodigo = {
  // Variáveis que o usuário pode mudar, configurações de sistema;
  "DEV": new Variavel(true),
};

void definicao(String linha) {
  List<String> valores = linha.split(Sistema.definicao);

  var valor;

  printDev(valores[1]);

  if (verificarSeEhString(valores[1])) {

    valor = valores[1].split('"')[1].trim();
    
  } else if (int.tryParse(valores[1]) != null){

    valor = int.parse(valores[1]);

  } else if (valores[1] == 'false' || valores == 'true'){

    if (valores[1] == 'false') {
      valor = false;
    } else {
      valor = true;
    }

  }
  else {
    throw erroDeLinha('Esta variável não é possível definir');
  }

  Variavel definido = new Variavel(valor);

  // print(valor);
  // print(valor.runtimeType);
  definicoesDoCodigo[valores[0].toString().trim()] = definido;
}

void printIsada(String linha) {
  String valorDoPrint = tirarValorDeFuncao(linha);
  List<String> valores = [];
  dynamic valorAnterior;

  if (valorDoPrint.contains('+')) {
    valores = valorDoPrint.split('+');
  } else {
    valores.add(valorDoPrint);
  }

  for (dynamic valor in valores) {
    // definicoesDoCodigo.keys.forEach((k) {
    //   print('>"${k.runtimeType}"<');
    // });

    // Se o valor contem aspas duplas significa que é umas string, logo não é uma variável
    if (verificarSeEhString(valor)) {
      printDev('É String!');
      print(valor);
      return;
    }

    if (verificarSeEhVariavel(valor)) {
      
      if (definicoesDoCodigo[valor]?.tipo == int) printDev('é um variavel com valor de int');


      printVariavel(valor);
      return;
    }

    

    throw erroDeLinha('Variável > $valor < não existe');
  }
}


