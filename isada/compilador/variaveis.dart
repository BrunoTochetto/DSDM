class Sistema {
  
  static const String comentario = '#';
  
  static const String print = 'print';

  static const String definicao = ' = ';
  
  static int numeroLinha = 1;

}


class Variavel {
  dynamic valor;
  late Type tipo;

  Variavel(this.valor){
    this.valor = valor;
    tipo = valor.runtimeType;
  }
}