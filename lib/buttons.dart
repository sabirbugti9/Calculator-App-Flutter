import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String buttonText;
  final VoidCallback? buttonTapped;

  const MyButton({
    super.key,
    this.color,
    this.textColor,
    required this.buttonText,
    this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped, // Handle tap action for each button
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 70, // Set button width
          height: 70, // Set button height
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: color, // Button color
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: buttonTapped, // Tap to trigger action
                splashColor: Colors.white, // Ripple color
                highlightColor:
                    Colors.white.withOpacity(0.1), // Highlight color
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20, // Button text size
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
