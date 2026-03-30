void testandoFuncoes(dynamic nomeFuncao, List acao) {
  print('#################');
  print(nomeFuncao.toString());
  print('#################');
  for (dynamic coisas in acao) {
    print(coisas.toString());
  }
}

String tirarValorDeFuncao(String linhaInteira) {
  String processado = '';
  processado = linhaInteira.split('(')[1];
  processado = processado.split(')')[0];

  return processado;
}