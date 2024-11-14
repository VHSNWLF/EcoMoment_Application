// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Usuario/GetUsuario.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:ecomoment_application/views/cadastro.dart';
import 'package:ecomoment_application/views/contaSemLogin.dart';
import 'package:ecomoment_application/views/form-ideia.dart';
import 'package:ecomoment_application/views/ideiasReutilizacao.dart';
import 'package:ecomoment_application/views/inicial.dart';
import 'package:ecomoment_application/views/login.dart';
import 'package:ecomoment_application/views/minhaConta.dart';
import 'package:ecomoment_application/views/pontosColeta.dart';
import 'package:provider/provider.dart';

class WidgetBottomAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  Pessoa user = Pessoa.n();
  WidgetBottomAppBar({required this.scaffoldKey});

  @override
  State<WidgetBottomAppBar> createState() => _WidgetBottomAppBarState();
}

class _WidgetBottomAppBarState extends State<WidgetBottomAppBar> {
  TextStyle nunito = TextStyle(fontFamily: 'Nunito');
    void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'Cadastre-se ou faça o Login',
          style: nunito,
        ),
        content: Text(
          'Essa funcionalidade é inacessivel para convidados. Faça o Login ou cadastre-se para ter acesso a essa funcionalidade',
          style: nunito,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('Entrar', style: nunito),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  )); // Fecha o diálogo
            },
          ),
          CupertinoDialogAction(
            child: Text('Cadastro', style: nunito),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cadastro(),
                  )); // Fecha o diálogo
            },
          ),
        ],
      ),
    ).then((_) {
      // Quando o diálogo é fechado (incluindo ao clicar fora)
      // Redireciona para a página de Login ou inicial se necessário
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Myinicial()), // Pode ser a página inicial ou login
        (route) => false, // Remove todas as rotas anteriores
      );
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    return Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 75,
              child: BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home_outlined, color: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Myinicial(),));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.pin_drop_outlined, color: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PontosColeta(),));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.black),
                        onPressed: () {
                          user.email == "" ? _showErrorDialog(context) :
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FormIdeia(),));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.lightbulb_outlined, color: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IdeiasReutilizacao(),));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.person_2_outlined, color: Colors.black),
                        onPressed: () {
                          user.email == "" ?
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SemLoginConta(),)) :
                          
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MinhaConta(),));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}