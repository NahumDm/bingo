import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bingo/Core/constants.dart';

class CardInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPlay;
  final String label;

  const CardInput({
    Key? key,
    required this.controller,
    required this.onPlay,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.green,
                    ], // Your gradient colors
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(2.5), // Thickness of the border
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: label,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Color.fromARGB(255, 206, 94, 133),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: onPlay,
          child: Text(
            'Play',
            style: TextStyle(
              fontSize: Constants.textFont,
              fontFamily: 'BitCount Grid Double',
              letterSpacing: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
