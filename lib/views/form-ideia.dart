// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Postagem/PostPostagem.dart';
import 'package:ecomoment_application/Data/Usuario/Usuario.dart';
import 'package:ecomoment_application/defaultWidgets/bottomAppBar.dart';
import 'package:ecomoment_application/defaultWidgets/drawer.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:ecomoment_application/views/inicial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/Postagem.dart';

class FormIdeia extends StatefulWidget {
  const FormIdeia({super.key});

  @override
  State<FormIdeia> createState() => _FormIdeiaState();
}

class _FormIdeiaState extends State<FormIdeia> {
  // Variáveis
  List<Postagemm> posts = [];
  // variáveis de forms
  GlobalKey<FormState> chave = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController ctrlNome = TextEditingController();
  TextEditingController ctrlDescricao = TextEditingController();
  TextEditingController ctrlMateriais = TextEditingController();
  TextEditingController ctrlInstrucoes = TextEditingController();
  int material = 0;
  String dificuldade = '';
  TextStyle obg = TextStyle(
      color: Color.fromARGB(255, 58, 125, 68),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  TextStyle labels = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black);
  TextStyle nunito = TextStyle(fontFamily: 'Nunito');
  // variáveis de espaço - altura
  final espacoH5 = SizedBox(height: 5);
  final espacoH10 = SizedBox(height: 10);
  final espacoH20 = SizedBox(height: 20);
  // variáveis de espaço - largura
  final espacoW10 = SizedBox(width: 10);
  // final espacoW20 = SizedBox(width: 20);

  Pessoa usuario = Pessoa.n();
  Usuario usuarioBD = Usuario();
  Future<void> loadData() async {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    usuario = await usuarioBD.getUsuario.buscarPessoaByEmail(user.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  // Construção do app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(35, 10, 35, 20),
                    child: Form(
                      key: chave,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 30,
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(345 / 360),
                                    child: Image.asset('assets/imgs/ideia.png'),
                                  ),
                                ),
                              ),
                              espacoW10,
                              Text(
                                'Publique uma ideia',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800),
                              ),
                              espacoW10,
                              SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                          espacoH20,
                          Row(
                            children: [
                              Text(
                                'SUA IDEIA',
                                style: TextStyle(
                                    color: Color(0xff3A7D44),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins'),
                              )
                            ],
                          ),
                          espacoH10,
                          Row(children: [
                            criaLabel('Nome da ideia '),
                          ]),
                          espacoH5,
                          TextFormField(
                            controller: ctrlNome,
                            maxLength: 80,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                ctrlNome.clear();
                                return 'Preencha o nome da ideia';
                              } else if (value.trim().length < 10) {
                                return 'O nome da ideia deve ter no mínimo 10 caracteres';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Escolha o mais explicativo possível',
                                hintStyle: nunito,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          espacoH20,
                          Row(
                            children: [criaLabel('Tipo de material: ')],
                          ),
                          FormField(
                            initialValue: 0,
                            validator: (value) {
                              if (value == 0 || material == 0) {
                                return 'Selecione o material correspondente';
                              } else {
                                return null;
                              }
                            },
                            builder: (field1) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text('Plástico'),
                                              value: 1,
                                              groupValue: material,
                                              onChanged: (value) {
                                                material = value!;
                                                field1.didChange(value);
                                                setState(() {});
                                              },
                                            ),
                                            RadioListTile(
                                              title: Text('Metal'),
                                              value: 2,
                                              groupValue: material,
                                              onChanged: (value) {
                                                material = value!;
                                                field1.didChange(value);
                                                setState(() {});
                                              },
                                            ),
                                            RadioListTile(
                                              title: Text('Papel'),
                                              value: 3,
                                              groupValue: material,
                                              onChanged: (value) {
                                                material = value!;
                                                field1.didChange(value);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text('Vidro'),
                                              value: 4,
                                              groupValue: material,
                                              onChanged: (value) {
                                                material = value!;
                                                field1.didChange(value);
                                                setState(() {});
                                              },
                                            ),
                                            RadioListTile(
                                              title: Text('Madeira'),
                                              value: 5,
                                              groupValue: material,
                                              onChanged: (value) {
                                                material = value!;
                                                field1.didChange(value);
                                                setState(() {});
                                              },
                                            ),
                                            RadioListTile(
                                              title: Text('Resíduo orgânico'),
                                              value: 6,
                                              groupValue: material,
                                              onChanged: (value) {
                                                material = value!;
                                                field1.didChange(value);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  if (!field1.isValid)
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            field1.errorText ?? '',
                                            style: TextStyle(
                                                color: Colors.red.shade800,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                          espacoH5,
                          espacoH20,
                          Row(
                            children: [
                              Text(
                                'INFORMAÇÕES IMPORTANTES',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 58, 125, 68),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Circe'),
                              )
                            ],
                          ),
                          espacoH20,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [
                                      criaLabel('Descrição da ideia: ')
                                    ],
                                  ),
                                  espacoH5,
                                  TextFormField(
                                    controller: ctrlDescricao,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 300,
                                    maxLines: null,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        ctrlDescricao.clear();
                                        return 'Preencha a descrição da ideia';
                                      } else if (value.trim().length < 10) {
                                        return 'A descrição da ideia deve ter no mínimo 10 caracteres';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText:
                                            'Descreva com detalhes como deve ser feito...',
                                        hintStyle: nunito,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          espacoH10,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [
                                      criaLabel('Materiais necessários: ')
                                    ],
                                  ),
                                  espacoH5,
                                  TextFormField(
                                    controller: ctrlMateriais,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 300,
                                    maxLines: null,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        ctrlMateriais.clear();
                                        return 'Informe os materiais necessários para ideia';
                                      } else if (value.trim().length < 10) {
                                        return 'A listagem dos materiais deve ter no mínimo 10 caracteres';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText:
                                            'Informe tudo o que vamos precisar...',
                                        hintStyle: nunito,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          espacoH10,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [criaLabel('Passo a passo: ')],
                                  ),
                                  espacoH5,
                                  TextFormField(
                                    controller: ctrlInstrucoes,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 300,
                                    maxLines: null,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        ctrlInstrucoes.clear();
                                        return 'Preencha as instruções da ideia';
                                      } else if (value.trim().length < 10) {
                                        return 'As instruções da ideia devem ter no mínimo 10 caracteres';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText:
                                            'Explique bem explicadinho como faremos...',
                                        hintStyle: nunito,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          espacoH10,
                          criaLabel('Dificuldade: '),
                          FormField(
                            initialValue: '',
                            validator: (value) {
                              if (value == '' || dificuldade == '') {
                                return 'Selecione a dificuldade de execução';
                              } else {
                                return null;
                              }
                            },
                            builder: (field2) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: RadioListTile(
                                      title: Text('Fácil'),
                                      value: 'facil',
                                      groupValue: dificuldade,
                                      activeColor:
                                          Color.fromARGB(255, 78, 158, 90),
                                      onChanged: (value) {
                                        dificuldade = value!;
                                        field2.didChange(value);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: RadioListTile(
                                      title: Text('Média'),
                                      value: 'media',
                                      groupValue: dificuldade,
                                      activeColor:
                                          Color.fromARGB(255, 255, 188, 54),
                                      onChanged: (value) {
                                        dificuldade = value!;
                                        field2.didChange(value);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: RadioListTile(
                                      title: Text('Difícil'),
                                      value: 'dificil',
                                      groupValue: dificuldade,
                                      activeColor:
                                          Color.fromARGB(255, 207, 18, 18),
                                      onChanged: (value) {
                                        dificuldade = value!;
                                        field2.didChange(value);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  if (!field2.isValid)
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            field2.errorText ?? '',
                                            style: TextStyle(
                                                color: Colors.red.shade800,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                          espacoH5,
                          Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.height * 0.35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(width: 2),
                              ),
                              child: imageFileList.isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Selecione suas fotos (Max: 10)",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              selectImages();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 58, 125, 68),
                                            ),
                                            child: Text(
                                              "Selecionar",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: CarouselSlider.builder(
                                              itemCount: imageFileList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index,
                                                      int realIndex) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: FileImage(File(
                                                          imageFileList[index]
                                                              .path)),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                              options: CarouselOptions(
                                                autoPlay: true,
                                                enableInfiniteScroll:
                                                    imageFileList.length >= 3
                                                        ? true
                                                        : false,
                                                enlargeCenterPage: true,
                                                aspectRatio: 2.0,
                                                viewportFraction: 0.8,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                selectImages();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 58, 125, 68),
                                              ),
                                              child: Text(
                                                "Mudar",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ],
                                      ),
                                    )),
                          espacoH10,
                          ElevatedButton(
                            onPressed: () async {
                              if (chave.currentState!.validate()) {
                                if (imageFileList.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Adicione pelo menos uma imagem da sua ideia"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Postagem realizada com sucesso!"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  await publicar();
                                  ctrlDescricao.clear();
                                  ctrlInstrucoes.clear();
                                  ctrlMateriais.clear();
                                  ctrlNome.clear();
                                  material = 0;
                                  dificuldade = '';
                                  imageFileList = [];
                                  setState(() {});
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: Text(
                                            'Erro ao concluir a postagem!',
                                            style: nunito,
                                          ),
                                          content: Text(
                                            'Dados já existentes ou incompletos.',
                                            style: nunito,
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text('OK', style: nunito),
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                            )
                                          ],
                                        ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 58, 125, 68),
                                fixedSize: Size(125, 50)),
                            child: Text(
                              'PUBLICAR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          espacoH10,
                          espacoH20,
                          espacoH20,
                          espacoH20
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          WidgetBottomAppBar(scaffoldKey: scaffoldKey)
        ],
      ),
    );
  }

  List<String> tipo = ['png', 'jpg', 'jpeg', 'mp4'];
  List<String> tiposSelecionados =
      []; // Lista para armazenar os tipos de cada arquivo
  List<XFile> imageFileList = []; // Lista de imagens selecionadas
  final ImagePicker imagePicker = ImagePicker();

  void selectImages() async {
    imageFileList = [];
    tiposSelecionados = []; // Limpa a lista ao selecionar novas imagens

    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Limite de 10 imagens
      if (imageFileList.length + selectedImages.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Você não pode selecionar mais de 10 imagens."),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Filtra as imagens que estão nos formatos permitidos
      List<XFile> filteredImages = selectedImages.where((image) {
        String extension = image.name.split('.').last.toLowerCase();
        return tipo.contains(extension);
      }).toList();

      // Verifica se algum arquivo foi descartado devido ao formato
      if (filteredImages.length < selectedImages.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Alguns arquivos foram ignorados por não estarem em um formato permitido."),
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Adiciona as imagens filtradas e seus tipos às listas
      imageFileList.addAll(filteredImages);

      tiposSelecionados.addAll(
        filteredImages.map((image) {
          String extension = image.name.split('.').last.toLowerCase();
          switch (extension) {
            case 'jpeg':
              return "image/jpeg";
            case 'jpg':
              return "image/jpg";
            case 'png':
              return "image/png";
            case 'mp4':
              return "video/mp4";
            default:
              return "unknown";
          }
        }),
      );
    }
    setState(() {});
  }

  Future<void> publicar() async {
    PostPostagem().publicar(
        ctrlNome.text,
        usuario.username,
        material,
        ctrlDescricao.text,
        ctrlMateriais.text,
        ctrlInstrucoes.text,
        dificuldade,
        imageFileList,
        tiposSelecionados);
  }

  RichText criaLabel(String text) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: text, style: labels),
        TextSpan(text: '*', style: obg)
      ]),
    );
  }
}
