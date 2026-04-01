import 'erros.dart';
import 'comandos.dart';

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

void printDev(String texto) {
  // if (definicoesDoCodigo['DEV']?.valor) return
  Cores.printar(texto, Cores.vermelho);
}

String tirarValorDeFuncao(String linhaInteira) {
  String processado = '';
  processado = linhaInteira.split('(')[1];
  processado = processado.split(')')[0];

  return processado;
}

bool isAlpha(String s) => RegExp(r'^[a-zA-Z]+$').hasMatch(s);

bool verificarSeEhString(String texto) {
  // print(texto);
  // print(texto.indexOf('"'));
  // print(texto.lastIndexOf('"'));
  // print(texto.indexOf('"') == texto.lastIndexOf('"'));

  // Se não tem aspas, significa que é um valor ou variável.
  if(!texto.contains('"') && !texto.contains("'")) return false;


  if (texto.contains('"')) {
    if (texto.indexOf('"') == texto.lastIndexOf('"')) throw erroDeLinha('Definição de String ou variável não existe.');
  } else {
    if (texto.indexOf("'") == texto.lastIndexOf("'")) throw erroDeLinha('Definição de String ou variável não existe.');
  }

  return true;
}

bool verificarSeEhVariavel(String texto) {

  if (definicoesDoCodigo.containsKey(texto)) {
    return true;
  }

  return false;
}

void printVariavel(String linha) {
  print(definicoesDoCodigo[linha]?.valor);
}