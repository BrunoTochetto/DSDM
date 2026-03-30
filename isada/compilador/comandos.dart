import 'funcoesAuxiliares.dart';

Map<String, dynamic> definicoesDoCodigo = {};


void definicao(String linha) {
  List<String> valores = linha.split('=');

  var valor;

  if (valores[1].contains('"')) {

    valor = valores[1].split('"')[1].trim();
    

  } else {
    if (int.tryParse(valores[1]) != null) {

      valor = int.parse(valores[1]);

    }
  
  }

  print(valor);
  print(valor.runtimeType);
  definicoesDoCodigo[valores[0].toString().trim()] = valor;
}

void printIsada(String linha) {
  String valorDoPrint = tirarValorDeFuncao(linha);

    
  // definicoesDoCodigo.keys.forEach((k) {
  //   print('>"${k}"<');
  // });

  // Se o valor contem aspas duplas significa que é umas string, logo não é uma variável
  if (valorDoPrint.contains('"')) {
    print(valorDoPrint);
    return;
  }

  if (definicoesDoCodigo.containsKey(valorDoPrint)) {
    printVariavel(valorDoPrint);
    return;
  }

  throw new Exception('Variavel não existe');
}

void printVariavel(String linha) {
  print(definicoesDoCodigo[linha]);
}