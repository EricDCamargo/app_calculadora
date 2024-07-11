import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculadoraHomePage(),
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  const CalculadoraHomePage({super.key});

  @override
  CalculadoraHomePageState createState() => CalculadoraHomePageState();
}

class CalculadoraHomePageState extends State<CalculadoraHomePage> {
  String display = '';
  double primeiroNumero = 0;
  double segundoNumero = 0;
  String operador = '';
  bool limpar = false;

  void entradaTexto(String digit) {
    setState(() {
      if (limpar) {
        display = digit;
        limpar = false;
      } else {
        if (display == '0') {
          display = digit;
        } else {
          display += digit;
        }
      }
    });
  }

  void entradaDosOperadores(String operadorSelecionado) {
    setState(() {
      primeiroNumero = double.parse(display);
      operador = operadorSelecionado;
      limpar = true;
    });
  }

  void resultadoCalculo() {
    setState(() {
      segundoNumero = double.parse(display);
      switch (operador) {
        case '+':
          display = (primeiroNumero + segundoNumero).toString();
          break;
        case '-':
          display = (primeiroNumero - segundoNumero).toString();
          break;
        case '*':
          display = (primeiroNumero * segundoNumero).toString();
          break;
        case '/':
          display = (primeiroNumero / segundoNumero).toString();
          break;
      }
      limpar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              display,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildOperatorButton('/'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildOperatorButton('*'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildOperatorButton('-'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('0'),
                _buildButton('.'),
                _buildEqualButton(),
                _buildOperatorButton('+'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      display = '0';
                      primeiroNumero = 0;
                      segundoNumero = 0;
                      operador = '';
                      limpar = false;
                    });
                  },
                  child: const Text('Limpar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        entradaTexto(buttonText);
      },
      child: Text(buttonText),
    );
  }

  Widget _buildOperatorButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        entradaDosOperadores(buttonText);
      },
      child: Text(buttonText),
    );
  }

  Widget _buildEqualButton() {
    return ElevatedButton(
      onPressed: () {
        resultadoCalculo();
      },
      child: const Text('='),
    );
  }
}
