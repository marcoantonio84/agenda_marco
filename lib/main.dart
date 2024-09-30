import 'package:flutter/material.dart';
import 'screens/contatos_page.dart'; // Importa a tela de contatos

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Marco',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ContatosPage(),  // Tela inicial
    );
  }
}
