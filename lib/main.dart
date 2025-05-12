import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'auth/auth_provider.dart';
import 'auth/auth_screen.dart';
import 'auth/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDnamObbd0BSZkaTbtVaEWGkhO_vykWpFU",
      appId: "1:168387735218:android:9633c2fdf109213a7aa3ab",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "fir-auth-34b24",
      authDomain: "YOUR_AUTH_DOMAIN",
      storageBucket: "fir-auth-34b24.firebasestorage.app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Auth Demo',
        debugShowCheckedModeBanner: false, // Add this line to remove debug banner
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user != null) {
      return const HomePage();
    }
    return const AuthScreen();
  }
}