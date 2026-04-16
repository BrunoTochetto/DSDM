

class Projetos {
  String nomeProjeto;
  DateTime dataInicio;
  DateTime dataFim;
  String descricaoProjeto;
  String coordenador;
  
  Projetos({
    required this.nomeProjeto,
    required this.dataInicio,
    required this.dataFim,
    required this.descricaoProjeto,
    required this.coordenador,
  });
}

class TamanhoCarrossell {
    static const double tmPequeno = 0.2;
    static const double tmNormal = 1;

    static final List<double> sizeNormal = [tmNormal, tmNormal-0.2];
    static final List<double> sizePequeno = [tmPequeno, tmPequeno];
    
    
}
