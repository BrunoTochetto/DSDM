// () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Descrição do projeto'),
//           content: Text(texto),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Fechar'),
//             ),
//           ],
//         ),
      // ),

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
