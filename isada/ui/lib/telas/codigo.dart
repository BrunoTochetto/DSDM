import 'dart:io';
import 'package:ui/telas/widgets/botaoRodar.dart';

import '../logica/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  List<FocusNode> focusNodes = List.generate(
    Ide.QUANTIDADE_LINHAS,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    // Inicializar focusNodes se necessário, mas já estão criados
  }

  void lerTodasAsLinhas() {
    List<String> codigo = [];
    for (TextEditingController texto in controladores) {
      codigo.add(texto.text);
    }
    rodarCodigo(codigo);
  }

  void shiftUp(int index) {
    setState(() {
      for (int j = index; j < controladores.length - 1; j++) {
        controladores[j].text = controladores[j + 1].text;
      }
      controladores.last.text = '';
    });
    focusNodes[index].requestFocus();
  }

  // Chat que falou
  @override
  void dispose() {
    // 2. Always dispose controllers to free resources
    for (var controller in controladores) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
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
              return Focus(
                focusNode: focusNodes[index],
                onKeyEvent: (FocusNode node, KeyEvent event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.backspace && controladores[index].text.isEmpty) {
                      shiftUp(index);
                      return KeyEventResult.handled;
                    }

                    if (event.logicalKey == LogicalKeyboardKey.enter ||event.logicalKey == LogicalKeyboardKey.numpadEnter || event.logicalKey == LogicalKeyboardKey.arrowDown ) {
                      if (index < controladores.length - 1) {
                        focusNodes[index + 1].requestFocus();
                        return KeyEventResult.handled;
                      }
                    }

                    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                      if (index > 0) {
                        focusNodes[index - 1].requestFocus();
                        return KeyEventResult.handled;
                      }
                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: TextField(
                  controller: controladores[index],
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        '${index + 1}. ',
                        style: TextStyle(fontSize: 12),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),

                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
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
