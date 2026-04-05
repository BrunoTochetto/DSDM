import 'package:flutter/material.dart';
import 'package:ui/logica/compilador/comandos/print.dart';

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TextoTerminal>>(
      valueListenable: TextoTerminal.terminalNotifier,
      builder: (context, terminal, child) {
        return Container(
          width: 10,
          decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 68, 68, 68),
            color: const Color.fromARGB(255, 194, 194, 194),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(terminal.length, (index) => terminal[index].widget)
                  ],
                ),
                )
            ],
          ),
        );
      }
    );
  }
}