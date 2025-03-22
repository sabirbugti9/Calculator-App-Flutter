import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calc/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userQuestion = '';
  var userAnswer = '';
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[700]);

  // Updated buttons list
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '√',
    '^2',
    '(',
    ')',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          ResultPart(userQuestion: userQuestion, userAnswer: userAnswer),
          ButtonPart(),
        ],
      ),
      
    );
  }





























  Expanded ButtonPart() {
    return Expanded(
      flex: 3,
      child: GridView.builder(
        itemCount: buttons.length,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Clear button
          if (index == 0) {
            return MyButton(
              buttonTapped: () {
                setState(() {
                  userQuestion = '';
                  userAnswer = '';
                });
              },
              buttonText: buttons[index],
              color: Colors.green,
              textColor: Colors.white,
            );
          }
          // Delete button
          else if (index == 1) {
            return MyButton(
              buttonTapped: () {
                setState(() {
                  if (userQuestion.isNotEmpty) {
                    userQuestion =
                        userQuestion.substring(0, userQuestion.length - 1);
                  }
                });
              },
              buttonText: buttons[index],
              color: Colors.red,
              textColor: Colors.white,
            );
          }
          // Equals button
          else if (index == buttons.length - 1) {
            return MyButton(
              buttonTapped: () {
                setState(() {
                  equalPressed();
                });
              },
              buttonText: buttons[index],
              color: Colors.deepPurple,
              textColor: Colors.white,
            );
          }
          // Square root button
          else if (buttons[index] == '√') {
            return MyButton(
              buttonTapped: () {
                setState(() {
                  userQuestion += '√(';
                });
              },
              buttonText: buttons[index],
              color: Colors.deepPurple,
              textColor: Colors.white,
            );
          }
          // Default button behavior
          else {
            return MyButton(
              buttonTapped: () {
                setState(() {
                  if (buttons[index] == 'ANS') {
                    userQuestion +=
                        userAnswer; // Append the last result when "ANS" is pressed
                  } else {
                    userQuestion += buttons[index];
                  }
                });
              },
              buttonText: buttons[index],
              color: isOperator(buttons[index])
                  ? Colors.deepPurple
                  : Colors.deepPurple[50],
              textColor:
                  isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
            );
          }
        },
      ),
    );
  }

  // Check if the button is an operator
  bool isOperator(String x) {
    return ['%', '/', '-', '+', '=', '*', '^2'].contains(x);
  }

  // Evaluate the expression
  void equalPressed() {
    try {
      String finalQuestion = userQuestion;

      // Replace √ with sqrt for evaluation
      finalQuestion = finalQuestion.replaceAll('√', 'sqrt');

      // Handle ^2 manually by expanding the expression
      finalQuestion = finalQuestion.replaceAllMapped(
        RegExp(r'(\d+)\^2'),
        (match) => '${match.group(1)}*${match.group(1)}',
      );

      // Parse and evaluate the expression
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result
      userAnswer =
          eval == eval.toInt() ? eval.toInt().toString() : eval.toString();
    } catch (e) {
      // Show error message for invalid input
      userAnswer = "Error";
    }
  }
}

class ResultPart extends StatelessWidget {
  const ResultPart({
    super.key,
    required this.userQuestion,
    required this.userAnswer,
  });

  final String userQuestion;
  final String userAnswer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const SizedBox(height: 20),
            // Question display
            Container(
              // padding: const EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 60, left: 12),
              alignment: Alignment.centerLeft,
              child: Text(userQuestion, style: const TextStyle(fontSize: 46)),
            ),
            // Answer display
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(userAnswer,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
