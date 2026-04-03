import 'package:flutter/material.dart';

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 68, 68, 68),
        color: const Color.fromARGB(255, 168, 168, 168),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: ListView(
        children: [
          Text('texto')
        ],
      ),
    );
  }
}