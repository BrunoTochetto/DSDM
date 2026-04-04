import 'comandos.dart';
import 'variaveis.dart';

class Cores {
  static const String ansiEscape = '\x1B';
  static const String colorReset = '$ansiEscape[0m';
  static const String vermelho = '$ansiEscape[31m';
  static const String verde = '$ansiEscape[32m';
  static const String amarelo = '$ansiEscape[33m';
  static const String azul = '$ansiEscape[34m';
  static const String magenta = '$ansiEscape[35m';
  static const String ciano = '$ansiEscape[36m';

  static const List<String> lista = [colorReset, vermelho, verde, amarelo, azul, magenta, ciano];

  static String texto(String texto, String cor) {return (cor + texto + Cores.colorReset);}
  static void printar(String texto, String cor) {print(cor + texto + Cores.colorReset);}
}

void testandoFuncoes(dynamic nomeFuncao, List acao) {
  print('#################');
  print(nomeFuncao.toString());
  print('#################');
  for (dynamic coisas in acao) {
    print(coisas.toString());
  }
}

void printDev(dynamic texto, [String cor = Cores.vermelho]) {
  if (variaveisDoCodigo['DEV']?.valor) return
  Cores.printar(texto.toString(), cor);
}

String tirarValorDeFuncao(String linhaInteira) {
  String processado = '';
  processado = linhaInteira.split('(')[1];
  processado = processado.split(')')[0];

  return processado;
}

bool isAlpha(String s) => RegExp(r'^[a-zA-Z]+$').hasMatch(s);

bool verificarSeEhString(String texto) { 
  
  printDev(texto, Cores.magenta);
  // Se não tem aspas, significa que é um valor ou variável.
  if(!texto.contains('"') && !texto.contains("'")) return false;
  
  if(!(texto[0] == '"' || texto[0] == "'")) throw ('Esta variável não é válida');

  
  if (texto.contains('"')) {
    // if (texto.indexOf('"', texto.indexOf('"')+1) != texto.lastIndexOf('"')) throw ('Concatenação inválida da String');
    if (texto.split('"').length != 3) throw ('Concatenação inválida da String');
    if (texto.indexOf('"') == texto.lastIndexOf('"')) throw ('String não existe.');

  } else {
    // if (texto.indexOf("'", texto.indexOf("'")+1) != texto.lastIndexOf("'")) throw ('Concatenação inválida da String');
    if (texto.split("'").length != 3) throw ('Concatenação inválida da String');
    if (texto.indexOf("'") == texto.lastIndexOf("'")) throw ('String não existe.');

  }

  return true;
}

bool verificarSeEhVariavel(String texto) {

  if (variaveisDoCodigo.containsKey(texto)) {
    return true;
  }

  return false;
}

String retornarStringSemAspas(String texto) {
  if (texto.contains('"')) {
    // if (texto.indexOf('"', texto.indexOf('"')+1) != texto.lastIndexOf('"')) throw ('Concatenação inválida da String');
    return texto.split('"')[1];

  } else {
    // if (texto.indexOf("'", texto.indexOf("'")+1) != texto.lastIndexOf("'")) throw ('Concatenação inválida da String');
    return texto.split("'")[1];
    
  }
}

void printVariavel(String linha) {
  print(variaveisDoCodigo[linha]?.valor);
}



// Dinamic denovo pq pode retornar um int e uma string;
dynamic logicaContasAvancadas(String valorCheio) {

  if (valorCheio.contains('*')) {
    List valores = valorCheio.split('*');

    var multiplicado = stringParaValor(valores[0]);
    var multiplicando = stringParaValor(valores[1]);

    return _multiplicacao([multiplicado, multiplicando]);
  } else if (valorCheio.contains('/')) {
    List valores = valorCheio.split('/');

    var dividendo = stringParaValor(valores[0]);
    var divisor = stringParaValor(valores[1]);

    if (divisor.runtimeType == String || dividendo.runtimeType == String) throw ('Não é possível dividir com Strings');
    return _divisao([dividendo, divisor]);
  }


}

dynamic _multiplicacao(List valores) {
  printDev('Lógica de multiplicação no print', Cores.azul);

  if (valores[1].runtimeType == String) throw ('Não é possível multiplicar algo por uma string');

  // if (valores[0].runtimeType == num)
  return (valores[0] * valores[1]);
}

num _divisao(List valores) {
  printDev('Lógica de divisão no print', Cores.azul);
  return valores[0] / valores[1];
}