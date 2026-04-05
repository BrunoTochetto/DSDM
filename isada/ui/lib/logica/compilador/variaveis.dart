import 'comandos.dart';
import 'funcoesAuxiliares.dart';
import "comandos/print.dart";

class Sistema {
  static const String comentario = '#';

  static const String print = 'print';

  static const String definicao = ' = ';

  static const String inicioInterpolacao = '\$' '{';

  static int numeroLinha = 1;
}

class Variavel {
  dynamic valor;
  late Type tipo;

  Variavel({required this.valor}) {
    printDev('Inicializado a classe Variável', Cores.ciano);
    valor = valor;
    tipo = valor.runtimeType;
  }
}

void zerarTodosOsValores() {  
  variaveisDoCodigo = {
    // Variáveis que o usuário pode mudar, configurações de sistema;
    "DEV": Variavel(valor: false),
  };
  Sistema.numeroLinha = 1;
  TextoTerminal.terminal = [];
}

// Infelizmente dynamic pois pode sair um int daqui
dynamic stringParaValor(String valor) {
  printDev('String para valor', Cores.azul);
  valor = valor.trim();
  if (valor.isEmpty) return '';

  if (verificarSeEhString(valor)) {
    
    if (valor.contains(Sistema.inicioInterpolacao)) {
      return _interpolacao(valor);
    }

    return retornarStringSemAspas(valor);

  } else if (num.tryParse(valor) != null) {

    return num.parse(valor);

  } else if (verificarSeEhVariavel(valor)) {

    return variaveisDoCodigo[valor]!.valor;

  } else if (valor.toString().toLowerCase() == "false" ||
      valor.toString().toLowerCase() == "true") {
    if (valor.toLowerCase() == 'false') {
      return false;
    } else {
      return true;
    }
  }
  throw ('Valor > $valor < não existe');
}

dynamic variaveisComValoresAdicionais(String valorEntrada) {
  printDev('Entrou em variáveis com valores adicionais', Cores.azul);
  String valorCheio = _inicioInterpolacao(valorEntrada);
  
  List<String> valores = valorCheio.split('+');


  var valorFinal;
  for (dynamic valor in valores) {
    dynamic valorDeSaida;
    valor = valor.trim();

    // ! Error
    // Se o verificarSeEhString() vem no final do If, ele TIRA o resto da conta do 2 * 6.. que estranho.
    if (!verificarSeEhString(valor) && valor.contains('*') || valor.contains('/')) {
      valorDeSaida = logicaContasAvancadas(valor);
    } else {
      valorDeSaida = stringParaValor(valor);
    }

    if (valorFinal == null) {
      valorFinal = valorDeSaida;
    } else {
      if (valorFinal.runtimeType != valorDeSaida.runtimeType &&
          valorFinal.runtimeType == num &&
          valorDeSaida.runtimeType == num)
        throw (
          'Não é possível concatenar dois tipos diferentes de dados.',
        );

      valorFinal += valorDeSaida;
    }
  }
  return (valorFinal);
}

dynamic _interpolacao(String valorEntrada) {
  printDev('Interpolando ', Cores.azul);
  String stringGeral = '';
  List<String> pegarVariavel = valorEntrada.split(Sistema.inicioInterpolacao);  
  for (String item in pegarVariavel) {
    if (!item.contains('}')) {stringGeral += item; continue;}
    List dividido = item.split('}');
    // String valorEncontrados = dividido[0];
    // printDev(dividido);
    // printDev(variaveisComValoresAdicionais(valorEncontrados));

    // // stringGeral += variaveisComValoresAdicionais(valorEncontrados).toString();
    // // } else {
    // //   throw ('Variável $valorEncontrados não existe');
    // // }
    // // depois do }
    stringGeral += dividido[1];
  }

  return retornarStringSemAspas(stringGeral);
}

String _inicioInterpolacao(String valorEntrada) {
  printDev('Identificado interpolação ', Cores.verde);
  String valorCheio;
  if (valorEntrada.contains(Sistema.inicioInterpolacao)){
    List<String> filtroInicial = valorEntrada.split(Sistema.inicioInterpolacao);
    
    List<String> outro = [];
    for (String linha in filtroInicial) {
      if (!linha.contains('}')) continue;
      List divisor = linha.split('}');
      
      outro.add(divisor[0]);
      outro.add(divisor[1]);
    }

    valorCheio = filtroInicial[0];
    for (int i = 0; i < outro.length; i++) {
    // for (String item in outro) {
      String item = outro[i];
      

      if (i % 2 == 1) {valorCheio += item; continue;}

      dynamic result = variaveisComValoresAdicionais(item).toString();
      printDev("Result: $result");
      valorCheio += result.toString();
      
    }
    
  } else {
    valorCheio = valorEntrada;
  }
  return valorCheio;
}