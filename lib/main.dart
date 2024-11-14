// ignore_for_file: prefer_const_constructors, unused_import

import 'package:ecomoment_application/views/inicial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/pessoaProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UsuarioProvider(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoMoment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255,58,125,68)),
        useMaterial3: true,
      ),
      home: Myinicial(),
    );
  }
}

