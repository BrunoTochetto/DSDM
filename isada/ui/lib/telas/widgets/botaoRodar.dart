import 'dart:async';
import 'package:flutter/material.dart';

class BotaoRodar extends StatefulWidget {
  final Function? onclick;

  const BotaoRodar(this.onclick, {super.key});

  @override
  State<BotaoRodar> createState() => _BotaorodarState();
}

class _BotaorodarState extends State<BotaoRodar> {
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      height: 30,
      width: 40,
      child: FilledButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            return null; // default color
          }),
        ),
        onPressed: _isDisabled
            ? null
            : () {
                setState(() => _isDisabled = true);
                widget.onclick?.call();
                Timer(Duration(seconds: 1), () {
                  setState(() => _isDisabled = false);
                });
              },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 0,
          children: [
            Icon(Icons.play_arrow, size: 20),
            // Text('Rodar')
          ],
        ),
      ),
    ));
  }
}