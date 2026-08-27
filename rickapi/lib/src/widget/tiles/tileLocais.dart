import "package:flutter/material.dart";
import "package:rickapi/model/local.dart";

class TileLocais extends StatelessWidget {
  final Local data;

  const TileLocais({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(data.name), subtitle: Text(data.type));
  }
}
