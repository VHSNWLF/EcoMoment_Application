// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Data/Usuario/Usuario.dart';
import '../models/pessoaProvider.dart';
import 'inicial.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState> keyVal = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  final buttonLabel = SizedBox(
      child: Text(
    "CADASTRAR",
    style: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<UsuarioProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
              Container(
                height: MediaQuery.of(context).size.height * 1.17,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/imgs/TeladeCadastro.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Form(
              key: keyVal,
              child: Container(
                
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/imgs/EcoMomenticon.ico",
                        width: 120,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Cadastro",
                        style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff94b64b),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    SizedBox(
                      width: 400,
                      child: Text(
                        "Nome:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Color(0xffe3ebf2),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Este campo não pode estar vazio. Preencha o campo corretamente";
                          } else if (value.trim().length < 10) {
                            return "O Nome Completo deve ter mais que 10 caracteres";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Text(
                        "Nome de usuário:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Color(0xffe3ebf2),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Este campo não pode estar vazio. Preencha o campo corretamente";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Text(
                        "Email:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Color(0xffe3ebf2),
                          filled: true,
                        ),
                        validator: (value) => !EmailValidator.validate(value!)
                            ? 'Digite um email válido'
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Text(
                        "Senha:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Color(0xffe3ebf2),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Este campo não pode estar vazio. Preencha o campo corretamente";
                          } else if (value.trim().length < 5) {
                            return "No minimo 5 caracteres";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Text(
                        "Repita a senha:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: passwordController2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Color(0xffe3ebf2),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Este campo não pode estar vazio. Preencha o campo corretamente";
                          } else if (value != passwordController.text) {
                            return "As senhas devem ser iguais";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (keyVal.currentState!.validate()) {
                            // Esperar o retorno da função assíncrona
                            bool exist = await usuario.getUsuario.verificaUsuarioExistente(
                                usernameController.text, emailController.text);

                            // Verificação simples após a resposta da função assíncrona
                            if (exist) {
                              // Mostrar o diálogo
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Usuário Já Cadastrado'),
                                    content: Text(
                                        'Usuário e/ou Email já estão cadastrados. Tente outro Usuário e/ou Email'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Fechar o diálogo
                                        },
                                        child: Text('Fechar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              print("Já existe usuário com esses dados");
                            } else {
                              // Se o usuário não existe, cadastrar a pessoa
                              await usuario.postUsuario.cadastrarPessoaEmailSenha(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text
                              );

                              await usuario.getUsuario.buscarPessoaByEmailAndSet(emailController.text, context);

                              // Atualizar o estado global
                              /* globalState.setUsername(usernameController.text);
                              globalState.setEmail(emailController.text);
                              globalState.setSenha(passwordController.text); */



                              // Navegar para a próxima página
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Myinicial(),
                                ),
                              );
                            }

                            setState(
                                () {}); // Atualizar o estado, se necessário
                          }
                        },
                        child: buttonLabel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3B5364),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Usuario usuario = Usuario();
}
