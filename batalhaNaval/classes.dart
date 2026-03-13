// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

void clearTerminal() {
  // ANSI escape code to clear the entire screen and move the cursor to 0;0
  stdout.write('\x1B[2J\x1B[0;0H');
}

void nada([dynamic a, dynamic b, dynamic c, dynamic d]) {}

// Cores para o terminal, pegados na net
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
class Ponto {
  int x;
  int y;
  bool ehNavio = false;
  String grifo = ' ';
  String cor;

  Ponto(this.x, this.y, this.ehNavio, [this.cor = Cores.colorReset]) {
    x = x;
    y = y;
    ehNavio = ehNavio;
    grifo;
  }

  void setGrifo(String grifo, [String cor = Cores.ansiEscape]) {
    this.grifo = grifo;
    if (cor != Cores.ansiEscape) this.cor = cor;
  }

  String getGrifoComCor() {
    return Cores.texto(this.grifo.toString(), this.cor);
  }

}

class Equipe {
  int acertos = 0;
  String nome;
  String cor = Cores.colorReset;

  Equipe([this.nome = '', this.cor = Cores.colorReset, this.acertos = 0]) {
    // Código de debug, se o nome já for selecionado na criação, quer dizer q é teste.
    // ToDO: Remover
    if (this.nome.length >= 1) {return;}
    

    // Selecionar o nome da equipe;
    String? nome;
    do {
      clearTerminal();
      print('Digite o nome da ${this.nome}. Deve ser menos de 16 Caracteres');
      nome = stdin.readLineSync();
    } while (nome!.length >=16 || nome.length == 0);
    this.nome = nome;
    clearTerminal();
    // Selecionar a cor da equipe;,

    // Isso pra facilitar a vida, não precisava. Dava pra fazer 1 linha.
    String selecaoCores = "0: Branco ";
    selecaoCores += "${Cores.vermelho} 1: Vermelho ${Cores.colorReset}";
    selecaoCores += "${Cores.verde} 2: Verde ${Cores.colorReset}";
    selecaoCores += "${Cores.amarelo} 3: Amarelo ${Cores.colorReset}";
    selecaoCores += "${Cores.azul} 4: Azul ${Cores.colorReset}";
    selecaoCores += "${Cores.magenta} 5: Magenta ${Cores.colorReset}";
    selecaoCores += "${Cores.ciano} 6: Ciano ${Cores.colorReset}";
    dynamic cor;
    while (true) {
      print('Selecione a cor da equipe: $nome');
      print(selecaoCores);
      cor = stdin.readLineSync();

      if (int.tryParse(cor!) != null) {

        if (int.parse(cor) >= 0 && int.parse(cor) <=6) {
          break;
        }
      }
    }
    this.cor = Cores.lista[int.parse(cor)];
    clearTerminal();
    
  }

  void incrementarAcertos() {
    this.acertos += 1;
  }

  String getNameComCor() {
    return Cores.texto(this.nome, this.cor);
  }

  bool inicializarNavios(Tabuleiro mapa) {
    clearTerminal();
    
    void mudarBorda(int x, int y) {
      if (y <= mapa.TAMANHO_TABULEIRO-3 && x <= mapa.TAMANHO_TABULEIRO-3) return null;

      mapa.tabuleiro[x][y].cor = Cores.vermelho;
      mapa.tabuleiro[x][y].grifo = 'X';
    }
    
    mapa.imprimirTabuleiro(false, Cores.colorReset, mudarBorda);
    print('\n' + this.getNameComCor() + ', selecione onde colocar o seu navio');
    print("Digite: Letra Número, Exemplo: E 4");

    int y;
    int x;

    // Isso tem muitas condições, melhor fazer um While True e só acabar ele com um break.
    while (true){
      String? input = stdin.readLineSync();
      // É usado continue para acabar a ITERAÇÃO atual, não acabar com o loop
      if (input == null) continue;
      if (!input.contains(' ')) {Cores.printar('Deve ser separado!', Cores.vermelho); continue;}
      List<String> dividido = input.split(' ');

      if (int.tryParse(dividido[1]) == null) {Cores.printar('Deve ser separado ou não é número.', Cores.vermelho); continue;}
      
      String letra = dividido[0].toLowerCase();
      int numero = int.parse(dividido[1]);
      // Verificar se está nas letras certas
      if (!letra.contains(RegExp('[a-n]'))) {print('Não pode colocar ai!'); continue;};
      // Verificar se está no número certo
      if (numero >= mapa.TAMANHO_TABULEIRO-1) {print('Não pode colocar ai!'); continue;};

      y = letra.codeUnitAt(0)-97;
      x = numero-1;

      break;
    }
    clearTerminal();

    // Vê se não tem nenhum outro navio nessa localização.
    Pattern? naoPode = mapa.previaNavios(x, y);
    
    // if (!deuMerda) {
    //   
    // };

    mapa.imprimirTabuleiro(false);
    print('Colocar o navio na (V) vertical ou (H) horizontal?');

    while(true) {
      String? input = stdin.readLineSync();
      if (input == null) continue;
      input = input[0].toLowerCase();
      if (naoPode != null) {
        if (input.contains(naoPode)) {
          clearTerminal();
          mapa._zerar();
          print('Vocês colocaram o navio no mesmo local... Terão que refazer tudo');
          return false;
        }
      }

      if (input == 'v' ) {
        mapa.colocarNavio(x, y, true);
        break;
      }
      else if (input == 'h') {
        mapa.colocarNavio(x, y, false);
        break;
      }
    }
    clearTerminal();
    mapa._zerar();
    return true;
  }
  
  
}

class Tabuleiro {
  List<List<Ponto>> tabuleiro = [];
  final int TAMANHO_TABULEIRO;
  // Queria fazer isso sem precisar colocar uma variável optativa
  int rodada;
  // ! Equipes
  // * Teste
  List<Equipe> equipes = [new Equipe('Draguisada', Cores.vermelho), new Equipe('Invertebrados', Cores.verde)];
  
  // * Real oficial
  // List<Equipe> equipes = [new Equipe(), new Equipe()];
  
  // Quando inicaliza o tabuleiro, é criado o tabuleiro e as equipes.
  Tabuleiro(this.TAMANHO_TABULEIRO, [this.rodada = 0]) {
    _criarTabuleiro();
  }

  // Itera por 2 listas de valores de TAMANHO_TABULEIRO, criando uma matrix.
  void _criarTabuleiro() {
    for (int y = 0; y < this.TAMANHO_TABULEIRO; y++) {
      List<Ponto> linhaAtual = [];
      for (int x = 0; x < this.TAMANHO_TABULEIRO; x++) {
        linhaAtual.add(Ponto(x, y, false));
      }
      this.tabuleiro.add(linhaAtual);
    }
  }

  // Um print bonito. Tem muita conta envolvida, me empolguei e fiz tudo comentado mas nem precisa.
  void imprimirTabuleiro([bool mostrarPlacar = true, String cor =  Cores.colorReset, Function regra = nada]) {
    cor = ' '*17 + cor;
    String linhaFinalNumero = '';
    // Responsável por fazer o cabeçalho inicial do tabuleiro, também usado para não precisar de lógico de inicio e fim para fazer uma impressão certa.
    // Como é em cima, colocar bonitinho as bordas, _border radius 2px_
    print(cor + '  /' +(('—'*3 + '+')*(this.TAMANHO_TABULEIRO-1)) + '—'*3 + '\\ ' + (mostrarPlacar ? _imprimirPlacar(-1, false) : '') + Cores.colorReset);
    for (int y = 0; y < this.TAMANHO_TABULEIRO; y++) {
      linhaFinalNumero += ' ${y+1} ' + (y >= 8 ? '': ' '); // Explicado lá em baixo
      // Coloca a letra do y, pegando a tabela ASCII e adicionando a letra com base no seu valor.
      String linhaAtual = String.fromCharCode(y + 65);
      linhaAtual += ' | '; // É iniciado com isso para não precisar de uma lógica de inicio e fim da criação do caracter. Apenas de fim.
      for (int x = 0; x < this.TAMANHO_TABULEIRO; x++) {
        
        // Para imprimir tudo na msm linha (Que eu achei até agora), é precisa criar uma String e depois imprimir ela.
        regra(x, y);
        linhaAtual += '${this.tabuleiro[x][y].getGrifoComCor()} | '; // Sabendo que já tem a parede inicial '| ', então vai adicionando até ficar X | até o final
      }
      // Sabendo que já tem as linhas de cima, ele printa o meio e então para baixo, e essa lógica é continuada pelo resto do tabuleiro
      print(cor + linhaAtual + (mostrarPlacar ? _imprimirPlacar(y, true) : '') + Cores.colorReset);
      // Lógica para deixar o meio do tabuleiro mais bonito. A conta basicamente faz:
      // | de inicio, e pelo meio é 3x—, então um +. Mas, pro final não pode ter o +, então se faz 3x— denovo e fecha com a barra.
      if (y != this.TAMANHO_TABULEIRO-1) print(cor + ' -|' +(('—'*3 + '*')*(this.TAMANHO_TABULEIRO-1)) + '—'*3 + '| ' + (mostrarPlacar ? _imprimirPlacar(y, false) : '') + Cores.colorReset) ;
    }
    // Imprimir a parte de baixo, com o _border radius_
    print(cor + '  \\' +(('—'*3 + '+')*(this.TAMANHO_TABULEIRO-1)) + '—'*3 + '/ ' + (mostrarPlacar ? _imprimirPlacar(this.TAMANHO_TABULEIRO, false) : '') + Cores.colorReset);
    // Imprimir os número também. Como é um quadrado perfeito, eu fui colocando os número pela repetição do Y para não ter que fazer outro loop aqui em baixo
    // Tem uma lógica para: Quando o digito foi único, coloca 2 espaços depois do número para alinhá-los na célula.
    // Assim que começar a ter 2 números, tira um dos espaços para alinhas os números de 2 digitos na célula.
    print(cor + ' '*3 + linhaFinalNumero + Cores.colorReset);
  }


  String _imprimirPlacar(int y, bool terTexto) {
    // Essa função é chamada toda linha, mostrando o y, isso faz com que possamos mudar o conteúdo dependendo da linha;
    // Como esta função tem que executar em todos os prints, e vários no mesmo y, apenas imprimirá nas mesmas colunas que as letras.

    const int TAMANHO_LINHA = 17;
    final int METADE_LINHA = (TAMANHO_LINHA/2).ceil();
    
    // Função para deixar mais bonito
    String imprimirNoMeioDaLinha(String texto, [String corInicial = Cores.colorReset]) {
      // Calculos matemáticos para deixar o texto no meio dado um determinado TAMANHO_LINHA;
      String metadeVazio = ' ' * (METADE_LINHA-(texto.length/2).ceil());
      return (corInicial + metadeVazio + texto + (texto.length % 2 == 0 ? metadeVazio.replaceFirst(' ', '') : metadeVazio) + Cores.colorReset);
    }
    
    // ! String inicial - "Cabeçalho"
    String placarDestaLinha = Cores.colorReset + ' |';

    // Parte de cima do placar
    if(y == -1) {
      return Cores.colorReset +' /' + '—'*TAMANHO_LINHA + '\\';
    }
    // Parte de baixo do placar
    else if (y == this.TAMANHO_TABULEIRO) {
      return Cores.colorReset +' \\' + '—'*TAMANHO_LINHA + '/';
    }
    // Retornam pq n vai ter mais nada ai

    // ! String do meio - "Corpo"
    if (terTexto) {
      // * Nota: Tentei fazer isso com Switch case mas ficou mt torto.
      if(y == 1) placarDestaLinha += imprimirNoMeioDaLinha('PLACAR');

      if(y == 2) placarDestaLinha += imprimirNoMeioDaLinha(equipes[0].nome, equipes[0].cor);
      if(y == 3) placarDestaLinha += imprimirNoMeioDaLinha('Acertos: ${equipes[0].acertos}', equipes[0].cor);

      if(y == 6) placarDestaLinha += imprimirNoMeioDaLinha(equipes[1].nome, equipes[1].cor);
      if(y == 7) placarDestaLinha += imprimirNoMeioDaLinha('Acertos: ${equipes[1].acertos}', equipes[1].cor);


      if(y == this.TAMANHO_TABULEIRO-2) placarDestaLinha += imprimirNoMeioDaLinha('Tentativas totais');
      if(y == this.TAMANHO_TABULEIRO-1) placarDestaLinha += imprimirNoMeioDaLinha(this.rodada.toString());
      // placarDestaLinha += imprimirNoMeioDaLinha('X'*y);

    }
    // Se ter texto ou não, se não ter texto "o suficiente", vai preencher para formar o quadrado
    if (placarDestaLinha.length <= TAMANHO_LINHA) placarDestaLinha += ' '*TAMANHO_LINHA;

    // ! String final - "Rodapé"
    placarDestaLinha += '| ';                                                                                             

    return placarDestaLinha;
  }

  void _imprimirHeader([String header = '']) {
    // O desenho ascii pego https://patorjk.com/software/taag/#p=display&f=AMC+Thin&t=Batalha+naval&x=sleek&v=4&h=4&w=80&we=false
    if (header == '') header = '\n███████████             █████              ████  █████                                                              ████\n▒▒███▒▒▒▒▒███           ▒▒███              ▒▒███ ▒▒███                                                              ▒▒███ \n ▒███    ▒███  ██████   ███████    ██████   ▒███  ▒███████    ██████      ████████    ██████   █████ █████  ██████   ▒███ \n ▒██████████  ▒▒▒▒▒███ ▒▒▒███▒    ▒▒▒▒▒███  ▒███  ▒███▒▒███  ▒▒▒▒▒███    ▒▒███▒▒███  ▒▒▒▒▒███ ▒▒███ ▒▒███  ▒▒▒▒▒███  ▒███ \n ▒███▒▒▒▒▒███  ███████   ▒███      ███████  ▒███  ▒███ ▒███   ███████     ▒███ ▒███   ███████  ▒███  ▒███   ███████  ▒███ \n ▒███    ▒███ ███▒▒███   ▒███ ███ ███▒▒███  ▒███  ▒███ ▒███  ███▒▒███     ▒███ ▒███  ███▒▒███  ▒▒███ ███   ███▒▒███  ▒███ \n ███████████ ▒▒████████  ▒▒█████ ▒▒████████ █████ ████ █████▒▒████████    ████ █████▒▒████████  ▒▒█████   ▒▒████████ █████\n ▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒    ▒▒▒▒▒   ▒▒▒▒▒▒▒▒ ▒▒▒▒▒ ▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒▒▒▒    ▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒▒▒▒    ▒▒▒▒▒     ▒▒▒▒▒▒▒▒ ▒▒▒▒▒ \n ';
    print(header);
  }

  void imprimirTabuleiroDeJogo() {
    _imprimirHeader();
    imprimirTabuleiro();
  }

  void _zerar([bool tirarNavios = false]) {
    mudarBorda(int x, int y) {
      // if (x >= 2 && y >= 2 && y <= this.TAMANHO_TABULEIRO-3 && x <= this.TAMANHO_TABULEIRO-3) return null;

      this.tabuleiro[x][y].cor = Cores.colorReset;
      this.tabuleiro[x][y].grifo = ' ';
      if (tirarNavios) this.tabuleiro[x][y].ehNavio = false;
    };
    imprimirTabuleiro(false, Cores.colorReset, mudarBorda);
    clearTerminal();
  }

    // Se não for vertical, vai ser horizontal
  void colocarNavio(int x, int y, bool vertical) {

    if (vertical) {
      this.tabuleiro[x][y].ehNavio = true;
      this.tabuleiro[x][y+1].ehNavio = true;
      this.tabuleiro[x][y+2].ehNavio = true;
    } else {
      this.tabuleiro[x+1][y].ehNavio = true;
      this.tabuleiro[x+2][y].ehNavio = true;
    }
  }

  Pattern? previaNavios(int x, int y) {
    this.tabuleiro[x][y].grifo = Cores.texto('X', Cores.vermelho);
    
    this.tabuleiro[x][y+1].grifo = Cores.texto('V', Cores.ciano);
    this.tabuleiro[x][y+2].grifo = Cores.texto('V', Cores.ciano);

    this.tabuleiro[x+1][y].grifo = Cores.texto('H', Cores.magenta);
    this.tabuleiro[x+2][y].grifo = Cores.texto('H', Cores.magenta);

    if (this.tabuleiro[x][y].ehNavio) return RegExp('V-H');

    if (this.tabuleiro[x][y+1].ehNavio ||this.tabuleiro[x][y+2].ehNavio) return RegExp('v');
    
    if (this.tabuleiro[x+1][y].ehNavio || this.tabuleiro[x+2][y].ehNavio) return RegExp('h');
    
    return null;
  }
}


