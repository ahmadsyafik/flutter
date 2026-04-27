import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Membungkus aplikasi dengan ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => TemperatureProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konversi Suhu',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto', // Pastikan font modern atau biarkan default
      ),
      home: const TemperatureConverterScreen(),
    );
  }
}

// ==========================================
// 1. STATE MANAGEMENT (PROVIDER)
// ==========================================
class TemperatureProvider extends ChangeNotifier {
  String _fromUnit = "Celsius";
  String _toUnit = "Fahrenheit";
  double _result = 0.0;
  String _inputText = "";

  // Getters
  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;
  double get result => _result;

  // Setters
  void setFromUnit(String value) {
    _fromUnit = value;
    notifyListeners();
  }

  void setToUnit(String value) {
    _toUnit = value;
    notifyListeners();
  }

  void setInputText(String value) {
    _inputText = value;
  }

  // Logika Konversi
  void convertTemperature() {
    double input = double.tryParse(_inputText) ?? 0;
    double tempInCelsius;

    // Convert ke Celsius dulu sebagai base
    if (_fromUnit == "Celsius") {
      tempInCelsius = input;
    } else if (_fromUnit == "Fahrenheit") {
      tempInCelsius = (input - 32) * 5 / 9;
    } else {
      tempInCelsius = input - 273.15;
    }

    // Convert dari Celsius ke target
    if (_toUnit == "Celsius") {
      _result = tempInCelsius;
    } else if (_toUnit == "Fahrenheit") {
      _result = (tempInCelsius * 9 / 5) + 32;
    } else {
      _result = tempInCelsius + 273.15;
    }

    // Beritahu UI untuk update
    notifyListeners();
  }
}

// ==========================================
// 2. USER INTERFACE (UI)
// ==========================================
class TemperatureConverterScreen extends StatelessWidget {
  const TemperatureConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan access ke provider
    final provider = context.watch<TemperatureProvider>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header Icon & Title
                        const Icon(
                          Icons.thermostat_rounded,
                          size: 64,
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Konversi Suhu",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Input Field
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) => 
                              context.read<TemperatureProvider>().setInputText(value),
                          decoration: InputDecoration(
                            labelText: "Masukkan Nilai Suhu",
                            prefixIcon: const Icon(Icons.numbers_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Dropdowns for Units
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                value: provider.fromUnit,
                                onChanged: (val) => context
                                    .read<TemperatureProvider>()
                                    .setFromUnit(val!),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.arrow_forward_rounded, 
                                color: Colors.grey),
                            ),
                            Expanded(
                              child: _buildDropdown(
                                value: provider.toUnit,
                                onChanged: (val) => context
                                    .read<TemperatureProvider>()
                                    .setToUnit(val!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Convert Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // Memanggil fungsi konversi
                              context.read<TemperatureProvider>().convertTemperature();
                              
                              // Opsional: Tutup keyboard setelah klik
                              FocusScope.of(context).unfocus();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              "KONVERSI",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Result Display
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.deepPurple.shade100, width: 2),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Hasil Konversi",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${provider.result.toStringAsFixed(2)} ${provider.toUnit}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  // Widget helper untuk dropdown agar kode lebih bersih
  Widget _buildDropdown({
    required String value,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: const [
        DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
        DropdownMenuItem(value: "Fahrenheit", child: Text("Fahrenheit")),
        DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
      ],
      onChanged: onChanged,
    );
  }
}