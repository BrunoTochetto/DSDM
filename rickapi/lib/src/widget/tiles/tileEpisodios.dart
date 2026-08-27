import "package:flutter/material.dart";
import "package:rickapi/model/episodio.dart";


class TileEpisodios extends StatelessWidget {
  final Episodio data;
  const TileEpisodios({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${data.name} | ${data.episode}"),
      subtitle: Text(data.air_date),
      );
  }
}