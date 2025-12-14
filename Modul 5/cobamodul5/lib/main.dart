import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Android',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const CalculatorScreen(),
    );
  }
}

// ==========================================================
// Stateful Widget untuk mengelola status kalkulator
// ==========================================================
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; // Tampilan utama
  String _currentInput = ""; // Input yang sedang diketik
  double _num1 = 0.0;
  String _operator = "";
  bool _clearInput = false; // Flag untuk reset input setelah operasi

  // Logika ketika tombol ditekan
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Reset semua
        _output = "0";
        _currentInput = "";
        _num1 = 0.0;
        _operator = "";
        _clearInput = false;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        // Simpan angka pertama dan operator
        if (_currentInput.isNotEmpty) {
          _num1 = double.tryParse(_currentInput) ?? 0.0;
        }
        _operator = buttonText;
        _output = _num1.toString() + " " + _operator;
        _clearInput = true;
      } else if (buttonText == ".") {
        // Hanya izinkan satu titik desimal
        if (!_currentInput.contains(".")) {
          _currentInput = _currentInput + buttonText;
        }
      } else if (buttonText == "=") {
        // Lakukan perhitungan
        if (_operator.isNotEmpty && _currentInput.isNotEmpty) {
          double num2 = double.tryParse(_currentInput) ?? 0.0;
          double result = 0.0;

          switch (_operator) {
            case "+":
              result = _num1 + num2;
              break;
            case "-":
              result = _num1 - num2;
              break;
            case "×":
              result = _num1 * num2;
              break;
            case "÷":
              if (num2 != 0) {
                result = _num1 / num2;
              } else {
                _output = "Error"; // Hindari pembagian dengan nol
                return;
              }
              break;
          }

          // Format output agar tidak ada .0 jika hasilnya bilangan bulat
          _output = (result % 1 == 0) ? result.toInt().toString() : result.toString();
          
          // Reset status untuk perhitungan berikutnya
          _num1 = result;
          _operator = "";
          _currentInput = _output;
          _clearInput = true;
        }
      } else {
        // Input angka
        if (_clearInput) {
          _currentInput = buttonText;
          _output = buttonText;
          _clearInput = false;
        } else {
          // Batasi panjang input (opsional)
          if (_currentInput.length < 15) {
            _currentInput = _currentInput + buttonText;
            _output = _currentInput;
          }
        }
      }
    });
  }

  // Widget untuk tombol kalkulator
  Widget _buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 
    return Scaffold(
      appBar: AppBar(
        title: const Text('KalkulatorKu'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Tampilan Output
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Divider(), // Pemisah antara output dan tombol
          ),
          // Baris-baris Tombol
          Column(children: [
            Row(children: [
              _buildButton("C", Colors.redAccent),
              _buildButton("÷", Colors.orange),
            ]),
            Row(children: [
              _buildButton("7", Colors.blueGrey),
              _buildButton("8", Colors.blueGrey),
              _buildButton("9", Colors.blueGrey),
              _buildButton("×", Colors.orange),
            ]),
            Row(children: [
              _buildButton("4", Colors.blueGrey),
              _buildButton("5", Colors.blueGrey),
              _buildButton("6", Colors.blueGrey),
              _buildButton("-", Colors.orange),
            ]),
            Row(children: [
              _buildButton("1", Colors.blueGrey),
              _buildButton("2", Colors.blueGrey),
              _buildButton("3", Colors.blueGrey),
              _buildButton("+", Colors.orange),
            ]),
            Row(children: [
              _buildButton("0", Colors.blueGrey),
              _buildButton(".", Colors.blueGrey),
              _buildButton("=", Colors.green),
            ]),
          ]),
        ],
      ),
    );
  }
}