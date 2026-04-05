import 'package:flutter/material.dart';
import 'package:ui/telas/codigo.dart';
import 'package:ui/telas/resultados.dart';

void main() {
  runApp(MaterialApp(
      home: const Telas(), 
    )
  );
}

class Telas extends StatefulWidget {
  const Telas({super.key});

  @override
  State<Telas> createState() => _TelasState();
}

class _TelasState extends State<Telas> {
  double dividerPosition = 0.5; // 80% for IDE, 20% for Results

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // IDE Section
            Expanded(
              flex: (dividerPosition * 100).toInt(),
              child: const Ide(),
            ),
            // Draggable Divider
            MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    final width = MediaQuery.of(context).size.width - 20; // Account for padding
                    dividerPosition = ((dividerPosition * width) + details.delta.dx) / width;
                    dividerPosition = dividerPosition.clamp(0.3, 0.9); // Clamp between 30% and 90%
                  });
                },
                child: Container(
                  width: 10,
                  color: Colors.grey[300],
                  child: Center(
                    child: Container(
                      width: 4,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
            // Results Section
            Expanded(
              flex: ((1 - dividerPosition) * 100).toInt(),
              child: const Resultados(),
            ),
          ],
        ),
      ),
    );
  }
}