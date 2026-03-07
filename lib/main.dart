import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {

  final TextEditingController _controller = TextEditingController();

  String fromUnit = "Celsius";
  String toUnit = "Fahrenheit";

  double result = 0;

  void convertTemperature() {
    double input = double.tryParse(_controller.text) ?? 0;

    double tempInCelsius;

    if (fromUnit == "Celsius") {
      tempInCelsius = input;
    } else if (fromUnit == "Fahrenheit") {
      tempInCelsius = (input - 32) * 5 / 9;
    } else {
      tempInCelsius = input - 273.15;
    }

    if (toUnit == "Celsius") {
      result = tempInCelsius;
    } else if (toUnit == "Fahrenheit") {
      result = (tempInCelsius * 9 / 5) + 32;
    } else {
      result = tempInCelsius + 273.15;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Konversi Suhu"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Konversi Suhu",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Masukkan suhu",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: DropdownButtonFormField(
                    value: fromUnit,
                    items: const [
                      DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                      DropdownMenuItem(value: "Fahrenheit", child: Text("Fahrenheit")),
                      DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        fromUnit = value!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: DropdownButtonFormField(
                    value: toUnit,
                    items: const [
                      DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                      DropdownMenuItem(value: "Fahrenheit", child: Text("Fahrenheit")),
                      DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        toUnit = value!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Konversi",
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Hasil: ${result.toStringAsFixed(2)} $toUnit",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}