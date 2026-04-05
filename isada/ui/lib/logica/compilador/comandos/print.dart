import '../variaveis.dart';
import '../funcoesAuxiliares.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TextoTerminal {
  static ValueNotifier<List<TextoTerminal>> terminalNotifier = ValueNotifier(
    [],
  );
  static List<TextoTerminal> get terminal => terminalNotifier.value;
  static set terminal(List<TextoTerminal> value) =>
      terminalNotifier.value = value;

  String texto;
  Color cor;
  late Widget widget;
  late TextStyle? estilo;

  TextoTerminal({required this.texto, this.cor = Colors.black87, this.estilo}) {
    widget = estilo == null ?  Text(texto, style: TextStyle(color: cor)) : Text(texto, style: estilo);
    terminalNotifier.value = [...terminalNotifier.value, this];
  }
}

void printSemValoresAdicionais(String valor) {
  printDev('Entrou no printSemValoresAdicionas', Cores.azul);

  dynamic stringFinal = stringParaValor(valor).toString();
  print(stringFinal);
  printTela(texto: stringFinal);
}

void printComValoresAdicionais(String valor) {
  printDev('Entrou em print com valores adicionais', Cores.azul);
  dynamic stringFinal = variaveisComValoresAdicionais(valor).toString();
  printDev('Resultado print:', Cores.verde);
  print(stringFinal);
  printTela(texto: stringFinal);
}

void printTela({required String texto, Color cor = Colors.black87, TextStyle? estilo}) {
  TextoTerminal(texto: texto, cor: cor, estilo: estilo);
}
