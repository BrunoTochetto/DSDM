import 'comandos.dart';
import 'funcoesAuxiliares.dart';
import 'erros.dart';

class Sistema {
  
  static const String comentario = '#';
  
  static const String print = 'print';

  static const String definicao = ' = ';
  
  static int numeroLinha = 1;

}


class Variavel {
  dynamic valor;
  late Type tipo;

  Variavel({ required this.valor}){
    this.valor = valor;
    tipo = valor.runtimeType;
  }
}


// Infelizmente dynamic pois pode sair um int daqui
dynamic stringParaValor(String valor) {
  valor = valor.trim();
  if (verificarSeEhString(valor)) {
      printDev('É String!', Cores.verde);


      return retornarStringSemAspas(valor);
    }
    else if (num.tryParse(valor) != null) {
      return num.parse(valor);
    }
    else if (verificarSeEhVariavel(valor)) {
    
    if (definicoesDoCodigo[valor]?.tipo == int) printDev('é um variavel com valor de int', Cores.verde);
    
    return definicoesDoCodigo[valor]!.valor;
  }
    
  throw erroDeLinha('Variável > $valor < não existe');
}