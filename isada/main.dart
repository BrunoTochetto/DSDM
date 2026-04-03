import 'dart:io';
import 'compilador/comandos.dart';
import 'compilador/erros.dart';
import 'compilador/funcoesAuxiliares.dart';
import 'compilador/variaveis.dart';



// Retorna um Future<List<String>>, linha por linha;
void main() async {
  final file = File('code.isada');

  try {
    List<String> lines = await file.readAsLines();
    
    for (String line in lines) {
      LeituraInicialDoCodigo(line);
      Sistema.numeroLinha += 1;
    }

  } catch (e) {
    printDeErroBonito('$e');
  }
}


void LeituraInicialDoCodigo(String linha) {
  // Ver se o comando ta certo
  if (linha.length <= 1) return;
  // Ignora comentários ANTES de ver se o caracter é alfabpetico
  if (linha[0] == Sistema.comentario) return;
  // Ver se o primeiro caracter é alfabético, se não dá erro
  if (!isAlpha(linha[0])) throw erroDeLinha('Não caracteres não alfabéticos no inicio de linhas');



  if (linha.contains(Sistema.print)) {printIsada(linha); return;}

  if (linha.contains(Sistema.definicao, 2)) {definicao(linha); return;}


  throw erroDeLinha('Este comando não existe');

}