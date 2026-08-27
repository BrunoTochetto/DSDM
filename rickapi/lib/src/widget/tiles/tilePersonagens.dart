import "package:flutter/material.dart";
import "package:rickapi/model/personagem.dart";

class TilePersonagem extends StatelessWidget {
  final Personagem data;
  
  TilePersonagem({super.key, required this.data});

  Map<String, String> status = {
    "Alive": "💚 Vivo",
    "Dead": "☠ Morto",
    "unknown": "?? Desconhecido",
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(data.image)),
      title: Text(data.name),
      subtitle: Text(status[data.status].toString()),
    );
  }
}
