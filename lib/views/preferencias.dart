// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Usuario/Usuario.dart';
import 'package:ecomoment_application/Funcionalidades/Funcionalidades.dart';
import 'package:ecomoment_application/defaultWidgets/drawer.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:ecomoment_application/views/cadastro.dart';
import 'package:ecomoment_application/views/editarPefil.dart';
import 'package:ecomoment_application/views/inicial.dart';
import 'package:ecomoment_application/views/login.dart';
import 'package:ecomoment_application/views/sobre_nos.dart';
import 'package:provider/provider.dart';

class TelaPreferencias extends StatefulWidget {
  const TelaPreferencias({super.key});

  @override
  State<TelaPreferencias> createState() => _TelaPreferenciasState();
}

class _TelaPreferenciasState extends State<TelaPreferencias> {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

Future<void> _showDeleteAccountDialog(BuildContext context) async {
  final user = Provider.of<UsuarioProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        'Excluir conta',
        style: nunito,
      ),
      content: Text(
        'Você tem certeza que deseja excluir sua conta EcoMoment?',
        style: nunito,
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Sim', style: nunito),
          onPressed: () async {
            // Deletar Conta
            await usuarioBD.postUsuario.excluirConta(usuario.idUsuarioWeb, usuario.username);
            Funcionalidades().Sair(context, user);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Myinicial()),
              (route) => false,
            );
          },
        ),
        CupertinoDialogAction(
          child: Text('Não', style: nunito),
          onPressed: () {
            Navigator.pop(context); // Fecha o diálogo sem ação
          },
        ),
      ],
    ),
  );
}
  Pessoa usuario = Pessoa.n();
  Usuario usuarioBD = Usuario();
  bool isLogged = false;

  Future<void>loadData() async{
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    usuario = await usuarioBD.getUsuario.buscarPessoaByEmail(user.email);
    setState(() {
      if(usuario.email.isEmpty || usuario.email == ""){
      isLogged = false;
    }else{
      isLogged = true;
    }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                        ),
                        Text(
                          'Preferências',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ajuda e Suporte',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => null,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/icon/conversando.png",
                                    height: 30,
                                    color: Color(0xff3A7D44),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Contate os editores",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () => null,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/icon/compartilhar.png",
                                    height: 30,
                                    color: Color(0xff3A7D44),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Compartilhe o EcoMoment",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SobreNos(),
                                )),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/icon/simbolo-de-reciclagem.png",
                                    height: 30,
                                    color: Color(0xff3A7D44),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sobre o EcoMoment",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ajuda e Suporte',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: 
                            isLogged ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditarPerfil(),)) : () => _showErrorDialog(context),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/icon/editar-informacao.png",
                                    height: 30,
                                    color: Color(0xff3A7D44),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Editar perfil",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap:
                            isLogged
      ? () => _showDeleteAccountDialog(context) 
      : () => _showErrorDialog(context),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/icon/coracao-partido.png",
                                    height: 30,
                                    color: Color(0xff3A7D44),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Desativar conta",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Image.asset("assets/imgs/MOMENT.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
