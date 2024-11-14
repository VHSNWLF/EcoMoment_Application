// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Usuario/Usuario.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  TextEditingController controller_nomeUsuario = TextEditingController();
  TextEditingController controller_sobreMim = TextEditingController();
  TextEditingController controller_senhaAtual = TextEditingController();
  TextEditingController controller_novaSenha1 = TextEditingController();
  TextEditingController controller_novaSenha2 = TextEditingController();
  GlobalKey<FormState> keyVal1 = GlobalKey();
  GlobalKey<FormState> keyVal2 = GlobalKey();

  Pessoa usuario = Pessoa.n();
  Usuario usuarioBD = Usuario();
  Future<void> loadData() async {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    usuario = await usuarioBD.getUsuario.buscarPessoaByEmail(user.email);
    controller_nomeUsuario.text = usuario.username;
    controller_sobreMim.text = usuario.biografia;
    fotoBlob = usuario.fotoPerfil!;

    // Adiciona um listener para verificar mudanças no campo de texto
    controller_nomeUsuario.addListener(() {
      final text = controller_nomeUsuario.text;
      // Garante que o texto sempre começa com "@"
      if (!text.startsWith("@")) {
        controller_nomeUsuario.value = TextEditingValue(
          text:
              "@${text.replaceAll('@', '')}", // Insere "@" no início e remove outros
          selection: TextSelection.fromPosition(
            TextPosition(offset: controller_nomeUsuario.text.length),
          ),
        );
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editar perfil",
          style: TextStyle(fontFamily: 'Circe', fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  usuario.fotoPerfil != null
                      ? CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: usuario.fotoPerfil != null
                              ? MemoryImage(fotoBlob)
                              : null,
                        )
                      : CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey[200],
                          child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: imageFile != null
                                  ? FileImage(imageFile!)
                                  : null),
                        ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showOpcoesBottomSheet();
                    },
                    child: Text(
                      "Alterar foto",
                      style: TextStyle(
                        fontFamily: 'Circe',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 58, 125, 68),
                    ),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: keyVal1,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nome de usuário:",
                            style: TextStyle(
                              fontFamily: 'Circe',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextFormField(
                          controller: controller_nomeUsuario,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Este campo não pode estar vazio. Preencha o campo corretamente";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sobre mim: ",
                            style: TextStyle(
                              fontFamily: 'Circe',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextField(
                          controller: controller_sobreMim,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                          ),
                          maxLines:
                              null, // Permite que o TextField expanda verticalmente
                          keyboardType: TextInputType
                              .multiline, // Para permitir múltiplas linhas
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (keyVal1.currentState!.validate()) {
                        usernameExist = await usuarioBD.getUsuario
                            .verificaUsuarioNomeWeb(
                                controller_nomeUsuario.text);
                        if (controller_nomeUsuario.text == usuario.username) {
                          _salvarFotoNomeBio();
                        } else if (usernameExist) {
                          _showMessageUsernameAlreadyExist();
                        } else {
                          _salvarFotoNomeBio();
                        }
                      }
                    },
                    child: Text(
                      "Alterar perfil",
                      style: TextStyle(
                        fontFamily: 'Circe',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 58, 125, 68),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alterar senha",
                      style: TextStyle(
                          fontFamily: 'Circe',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Senha atual: ",
                      style: TextStyle(
                        fontFamily: 'Circe',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Form(
                    key: keyVal2,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Este campo não pode estar vazio. Preencha o campo corretamente";
                            } else if (value.trim() != usuario.senha) {
                              return "Senha incorreta!";
                            }
                            return null;
                          },
                          controller: controller_senhaAtual,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            isDense: true,
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nova senha: ",
                            style: TextStyle(
                              fontFamily: 'Circe',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Este campo não pode estar vazio. Preencha o campo corretamente";
                            }
                            return null;
                          },
                          controller: controller_novaSenha1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            isDense: true,
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirme a senha atual: ",
                            style: TextStyle(
                                fontFamily: 'Circe',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Este campo não pode estar vazio. Preencha o campo corretamente";
                            } else if (controller_novaSenha1.text.trim() !=
                                controller_novaSenha2.text.trim()) {
                              return "As senhas devem ser iguais!";
                            }
                            return null;
                          },
                          controller: controller_novaSenha2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (keyVal2.currentState!.validate()) {
                        _salvarSenha();
                      }
                    },
                    child: Text(
                      "Alterar senha",
                      style: TextStyle(
                        fontFamily: 'Circe',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 58, 125, 68),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showMessageUsernameAlreadyExist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nome de Usuário Existente'),
          content:
              Text('Nome de Usuário já existe. Tente outro Nome de Usuário'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  bool usernameExist = false;
  Uint8List fotoBlob = Uint8List(0);

  _salvarFotoNomeBio() {
    usuarioBD.postUsuario.atualizarFotoAndNomeUsuarioAndSobreMim(
        fotoBase64,
        controller_nomeUsuario.text,
        controller_sobreMim.text,
        usuario.idUsuarioWeb);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Atualizado com sucesso!"), duration: Duration(seconds: 1),),
    );
  }

  _salvarSenha() {
    usuarioBD.postUsuario
        .atualizarSenha(controller_novaSenha2.text, usuario.idUsuarioWeb);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Senha atualizada com sucesso!"),
      ),
    );
  }

  final imagePicker = ImagePicker();
  File? imageFile;
  String? fotoBase64;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // Convertendo a imagem para formato blob (Uint8List)
      fotoBlob = await imageFile!.readAsBytes();

      setState(() {
        
      });

      // Codificando a imagem para Base64
      fotoBase64 = base64Encode(fotoBlob);
    }
  }

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.abc,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: ()  {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.restore_from_trash_sharp,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tornar a foto null
                  setState(() {
                    imageFile = null;
                    fotoBlob = Uint8List(0);
                    fotoBase64 = "";
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
