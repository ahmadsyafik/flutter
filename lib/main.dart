// lib/main.dart
// ✅ FILE DIUBAH - Tambah Firebase init + MultiProvider + halaman awal → LoginPage

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/auth_provider.dart';
import 'providers/temperature_provider.dart';
import 'pages/login_page.dart';

void main() async {
  // ✅ TAMBAHAN: wajib ada sebelum Firebase.initializeApp()
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ TAMBAHAN: Inisialisasi Firebase - selalu perlu dipanggil
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD5yswt5j4YOLFKmooryF-0l2Xxh7BEd9o',
        appId: '1:702308275388:android:6d4735df2b44731f076cb9',
        messagingSenderId: '702308275388',
        projectId: 'suhu-1eea1',
        storageBucket: 'suhu-1eea1.firebasestorage.app',
        authDomain: 'suhu-1eea1.firebaseapp.com',
      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(
    // ✅ DIUBAH: dari ChangeNotifierProvider biasa → MultiProvider
    //    karena sekarang ada 2 provider: AuthProvider + TemperatureProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TemperatureProvider()),
      ],
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
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // ✅ DIUBAH: home sekarang LoginPage, bukan langsung TemperatureConverterScreen
      home: const LoginPage(),
    );
  }
}
