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
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 151, 64, 64),
                      width: 2.0,
                    ),
                  ),
                  labelText: label,
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
