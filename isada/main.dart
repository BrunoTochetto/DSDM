import 'dart:io';
import 'compilador/comandos.dart';
import 'compilador/variaveis.dart';

// Retorna um Future<List<String>>, linha por linha;
void main() async {
  final file = File('code.isada');

  try {
    List<String> lines = await file.readAsLines();
    
    for (String line in lines) {
      LeituraInicialDoCodigo(line);
    }

  } catch (e) {
    print('Um erro ocorreu com o código: $e');
  }

  print(definicoesDoCodigo);
}


void LeituraInicialDoCodigo(String linha) {
  if (linha.length <= 1) return;

  if (linha[0] == comandosSistema.comentario) return;

  if (linha.contains('print')) {printIsada(linha); return;}

  if (linha.contains(" = ", 2)) {definicao(linha); return;}

}