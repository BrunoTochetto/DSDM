import 'package:ui/logica/compilador/comandos/print.dart';
import 'package:flutter/material.dart';

import 'funcoesAuxiliares.dart';

void printDeErroBonito(e) {
  String barras = ('=' * e.length);

  const estiloDeMedo = TextStyle(
    backgroundColor: Colors.redAccent,
    fontWeight: FontWeight(600)
  );
  printTela(texto: barras, estilo: estiloDeMedo);
  printTela(texto: e, estilo: estiloDeMedo);
  printTela(texto: barras, estilo: estiloDeMedo);

}
