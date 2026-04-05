import 'dart:io';
import 'package:ui/telas/widgets/botaoRodar.dart';

import '../logica/main.dart';
import 'package:flutter/material.dart';

class Ide extends StatefulWidget {
  const Ide({super.key});

  static const int QUANTIDADE_LINHAS = 50;

  @override
  _IdeState createState() => _IdeState();
}

class _IdeState extends State<Ide> {
  List<TextEditingController> controladores = List.generate(
    Ide.QUANTIDADE_LINHAS,
    (index) => TextEditingController(),
  );

  void lerTodasAsLinhas() {
    List<String> codigo = [];
    for (TextEditingController texto in controladores) {
      codigo.add(texto.text);
    }
    rodarCodigo(codigo);
  }

  // Chat que falou
  @override
  void dispose() {
    // 2. Always dispose controllers to free resources
    for (var controller in controladores) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BotaoRodar(lerTodasAsLinhas)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 68, 68, 68),
          color: const Color.fromARGB(255, 168, 168, 168),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ElevatedButton(onPressed: onMounted, child: Text('ler código')),
            // 3. Generate the TextField widgets
            ...List.generate(controladores.length, (index) {
              return TextField(
                controller: controladores[index],
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      '${index + 1}. ',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),

                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void onMounted() async {
    final file = File('../code.isada');

    try {
      List<String> lines = await file.readAsLines();

      for (int i = 0; i < controladores.length; i++) {
        controladores[i].text = lines[i];
        // controladores[i].text = '1';
      }
    } catch (e) {
      print('Um erro ocorreu com o código: $e');
    }
  }
}
