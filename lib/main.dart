import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
      } else if (buttonText == "+/-") {
        _output = (double.parse(_output) * -1).toString();
      } else if (buttonText == "%") {
        _output = (double.parse(_output) / 100).toString();
      } else if (buttonText == "=") {
        _output = _calculate();
      } else if (buttonText == "√") {
        _output = math.sqrt(double.parse(_output)).toString();
      } else if (buttonText == "^") {
        _output = _output + "^";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  String _calculate() {
    List<String> operations = _output.split(RegExp(r'[-+×÷]'));

    List<String> operators = [];
    for (String operation in _output.split(RegExp(r'[0-9.]'))) {
      if (operation.isNotEmpty) {
        operators.add(operation);
      }
    }

    List<String> baseAndExponent = _output.split("^");
    if (baseAndExponent.length == 2) {
      double base = double.parse(baseAndExponent[0]);
      double exponent = double.parse(baseAndExponent[1]);
      double result = math.pow(base.toDouble(), exponent.toDouble()).toDouble();
      return result.toString();
    }

    double result = double.parse(operations[0]);

    for (int i = 0; i < operators.length; i++) {
      String operator = operators[i];
      double operand = double.parse(operations[i + 1]);

      if (operator == "+") {
        result += operand;
      } else if (operator == "-") {
        result -= operand;
      } else if (operator == "×") {
        result *= operand;
      } else if (operator == "÷") {
        result /= operand;
      }
    }
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("÷"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("×"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("+/-"),
              _buildButton("+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton("%"),
              _buildButton("="),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton("√"), 
              _buildButton("^"), 
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0.8)),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }
}
