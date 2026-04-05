import 'dart:io';
import 'package:ui/logica/compilador/comandos/print.dart';

import 'compilador/comandos.dart';
import 'compilador/erros.dart';
import 'compilador/funcoesAuxiliares.dart';
import 'compilador/variaveis.dart';

void rodarCodigo(List<String> codigo) async {
    
    try {
      zerarTodosOsValores();

      for (String linha in codigo) {
        leituraInicialDoCodigo(linha);
        Sistema.numeroLinha += 1;
      }
  } catch (e) {
    printDeErroBonito('Erro na linha ${Sistema.numeroLinha}: $e');
  }
  printTela(texto: variaveisDoCodigo['DEV']?.valor);
}


void leituraInicialDoCodigo(String linha) {
  // Ver se o comando ta certo
  if (linha.length <= 1) return;
  // Ignora comentários ANTES de ver se o caracter é alfabpetico
  if (linha[0] == Sistema.comentario) return;
  // Ver se o primeiro caracter é alfabético, se não dá erro
  if (!isAlpha(linha[0])) throw ('Não caracteres não alfabéticos no inicio de linhas');

  printDev('='*6, Cores.magenta);
  printDev("Linha ${Sistema.numeroLinha}", Cores.magenta);

  if (linha.contains(Sistema.print)) {printIsada(linha); return;}

  if (linha.contains(Sistema.definicao, 2)) {definicao(linha); return;}


  throw ('Este comando não existe');

}