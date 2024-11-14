// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, prefer_final_fields, avoid_function_literals_in_foreach_calls, unused_import, prefer_const_declarations, unused_local_variable

import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Comentario/GetComentario.dart';
import 'package:ecomoment_application/Data/Comentario/PostComentario.dart';
import 'package:ecomoment_application/Data/Curtida/Curtida.dart';
import 'package:ecomoment_application/Data/IdeiaSalva/IdeiaSalvaData.dart';
import 'package:ecomoment_application/Data/Postagem/GetPostagem.dart';
import 'package:ecomoment_application/Data/Postagem/Postagem.dart';
import 'package:ecomoment_application/Data/Usuario/Usuario.dart';
import 'package:ecomoment_application/defaultWidgets/bottomAppBar.dart';
import 'package:ecomoment_application/defaultWidgets/drawer.dart';
import 'package:ecomoment_application/models/Comentarios.dart';
import 'package:ecomoment_application/models/ideia.dart';
import 'package:ecomoment_application/models/ideiaSalva.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:ecomoment_application/views/cadastro.dart';
import 'package:ecomoment_application/views/login.dart';
import 'package:ecomoment_application/views/minhaConta.dart';
import 'package:ecomoment_application/views/outraConta.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageIdeia extends StatefulWidget {
  Ideia ideia = Ideia.vazia();

  PageIdeia.ideia(this.ideia, {super.key});

  @override
  State<PageIdeia> createState() => _IdeiaState();
}

class _IdeiaState extends State<PageIdeia> {
  TextStyle titulo = TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'Poppins',
  );
  TextStyle autor = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: 'Poppins',
  );

  String tipo = "";

  TextEditingController controllerComentario = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Color definirCor(String dificuldade) {
    if (dificuldade == "facil") {
      return Colors.green;
    } else if (dificuldade == "media") {
      return Colors.yellow;
    } else if (dificuldade == "dificil") {
      return Colors.red;
    }
    return Colors.black;
  }

  Future<void> curtir() async {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    setState(() {
      if (isFavorited) {
        //função descurtir
        curtidaBD.postCurtida
            .descurtir(ideia.idPostagem, user.idUsuarioWeb, ideia.nomeUsuario);
        isFavorited = !isFavorited;
      } else {
        //função curtir
        curtidaBD.postCurtida
            .curtir(ideia.idPostagem, user.idUsuarioWeb, ideia.nomeUsuario);
        isFavorited = !isFavorited;
      }
      scaleUp = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        scaleUp = false;
      });
    });
  }

  Future<void> comentar(
      int idPostagem, int idUsuarioWeb, String comentario) async {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    PostComentario().comentar(idPostagem, idUsuarioWeb, comentario);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Comentario feito com sucesso"),
        duration: Durations.short2,
      ),
    );
    setState(() {});
  }

  Future<void> avaliar() async {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    setState(() {
      if (isRated) {
        //função reavaliar
        postagemBD.postPostagem.reavaliarIdeia(
            user.idUsuarioWeb, ideia.idPostagem, _avaliacao, ideia.nomeUsuario);
      } else {
        //função avaliar
        postagemBD.postPostagem.avaliarIdeia(
            user.idUsuarioWeb, ideia.idPostagem, _avaliacao, ideia.nomeUsuario);
        isRated = !isRated;
      }
    });
  }

  String snackSv = "Adicionado aos Favoritos!";

  Future<void> salvar() async {
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    setState(() {
      if (isSaved) {
        //função desalvar
        snackSv = "Removido dos favoritos!";
        ideiaSalvaBD.postIdeiaSalva
            .deleteIdeiaSalva(user.idUsuarioWeb, ideia.idPostagem);
        isSaved = !isSaved;
      } else {
        //função salvar
        snackSv = "Adicionado aos Favoritos!";
        ideiaSalvaBD.postIdeiaSalva
            .salvarIdeia(user.idUsuarioWeb, ideia.idPostagem);
        isSaved = !isSaved;
      }
      scaleUp2 = true;

      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          scaleUp2 = false;
        });
      });
    });
  }

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
    );
    ;
  }

  bool scaleUp = false;
  bool scaleUp2 = false;
  bool isFavorited = false;
  bool isRated = false;
  bool isSaved = false;
  bool isLoading = false;
  String av = "Enviar avaliação";
  Curtida curtidaBD = Curtida();
  IdeiaSalvaData ideiaSalvaBD = IdeiaSalvaData();
  Postagem postagemBD = Postagem();
  Usuario usuarioBD = Usuario();
  GetComentario getCometariosBD = GetComentario();
  List<Comentarios> listaComentarios = [];
  int countComentarios = 0;
  Pessoa pessoa = Pessoa.n();
  Ideia ideia = Ideia.vazia();
  List<Uint8List> imagens = [];
  bool isLoading2 = true;
  Future<void> _loadData() async {
    setState(() {
      isLoading = false;
    });
    final user = Provider.of<UsuarioProvider>(context, listen: false);
    ideia = await GetPostagem()
        .buscarIdeiaByNomePostagem(widget.ideia.nomePostagem);
    // Adiciona as imagens não nulas à lista
    if (ideia.img1 != null) imagens.add(ideia.img1!);
    if (ideia.img2 != null) imagens.add(ideia.img2!);
    if (ideia.img3 != null) imagens.add(ideia.img3!);
    if (ideia.img4 != null) imagens.add(ideia.img4!);
    if (ideia.img5 != null) imagens.add(ideia.img5!);
    if (ideia.img6 != null) imagens.add(ideia.img6!);
    if (ideia.img7 != null) imagens.add(ideia.img7!);
    if (ideia.img8 != null) imagens.add(ideia.img8!);
    if (ideia.img9 != null) imagens.add(ideia.img9!);
    if (ideia.img10 != null) imagens.add(ideia.img10!);
    isLoading2 = false;
    setState(() {});
    listaComentarios = await getCometariosBD.listaComentarios(ideia.idPostagem);
    countComentarios = listaComentarios.length;
    pessoa =
        await usuarioBD.getUsuario.buscarPessoaByNomeWeb(ideia.nomeUsuario);
    isFavorited = await curtidaBD.getCurtida
        .isFavorited(user.idUsuarioWeb, ideia.idPostagem);
    isSaved = await ideiaSalvaBD.getIdeiaSalva
        .isSaved(user.idUsuarioWeb, ideia.idPostagem);
    setState(() {});
    isRated = await postagemBD.getPostagem
        .isRated(user.idUsuarioWeb, ideia.idPostagem);
    if (isRated) {
      _avaliacao = await postagemBD.getPostagem
          .valorAvaliacao(user.idUsuarioWeb, ideia.idPostagem);
      av = "Mudar avaliação";
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();

    setState(() {});
  }

  int _avaliacao = 0; // Armazena a avaliação selecionada

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
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                        ),
                      ),
                      Text(
                        ideia.nomePostagem,
                        style: titulo,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      GestureDetector(
                        onTap: () => user.username == ideia.nomeUsuario
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MinhaConta(),
                                ))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ContaUsuario.pessoa(pessoa),
                                )),
                        child: Text(ideia.nomeUsuario, style: autor),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      isLoading2
                          ? Center(
                              child:
                                  CircularProgressIndicator()) // Exibe o indicador de progresso
                          : imagens.isNotEmpty
                              ? CarouselSlider.builder(
                                  itemCount: imagens.length,
                                  itemBuilder: (BuildContext context, int index,
                                      int realIndex) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        imagens[index],
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 2.0,
                                    viewportFraction: 0.8,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/imgs/ideia1.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      ...gerarEstrelaColorida(ideia.avaliacao),
                                      ...gerarEstrelaNColorida(
                                          5 - ideia.avaliacao)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Avaliações: ",
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                        Text(
                                          ideia.qtdeAvaliacoesPostagem
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        /*  */
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Dificuldade "),
                                    Icon(
                                      Icons.circle,
                                      color: definirCor(ideia.dificuldade),
                                      size: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Favoritar"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                          onTap: /* user.name */ user.email ==
                                                  ""
                                              ? () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CupertinoAlertDialog(
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
                                                          child: Text('Entrar',
                                                              style: nunito),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Login(),
                                                                )); // Fecha o diálogo
                                                          },
                                                        ),
                                                        CupertinoDialogAction(
                                                          child: Text(
                                                              'Cadastro',
                                                              style: nunito),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Cadastro(),
                                                                )); // Fecha o diálogo
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              : () async {
                                                  salvar();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(snackSv),
                                                      duration:
                                                          Duration(seconds: 1),
                                                    ),
                                                  );
                                                  setState(() {});
                                                },
                                          child: AnimatedScale(
                                            scale: scaleUp2 ? 1.5 : 1.0,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            child: Icon(
                                              isSaved
                                                  ? Icons.star_rate_rounded
                                                  : Icons.star_border_rounded,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Curtir "),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                          onTap: /* user.name */
                                              user.email == ""
                                                  ? () {
                                                      _showErrorDialog(context);
                                                    }
                                                  : () async {
                                                      curtir();
                                                      /* ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Avaliação de $_avaliacao estrelas!')),
                                                  ); */
                                                    },
                                          child: AnimatedScale(
                                            scale: scaleUp ? 1.5 : 1.0,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            child: Icon(
                                              isFavorited
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Compartilhar "),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.share,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                        onTap: () async {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 217, 217),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.boxOpen),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Materiais",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Circe',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [Text(ideia.materiais)],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.shoePrints),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Passo a Passo",
                              style: TextStyle(
                                  fontFamily: 'Circe',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Text(
                              ideia.passoPasso,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(Icons.border_color_sharp),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Avalie esta ideia!",
                              style: TextStyle(
                                  fontFamily: 'Circe',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _avaliacao
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                _avaliacao = index +
                                    1; // Define a avaliação baseada na estrela clicada
                              });
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: user.email == ""
                            ? () {
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
                                                builder: (context) =>
                                                    Cadastro(),
                                              )); // Fecha o diálogo
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            : () async {
                                avaliar();
                                print('Avaliação enviada: $_avaliacao');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Avaliação de $_avaliacao estrelas!')),
                                );
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 58, 125, 68),
                    ),
                        child: Text(av, style: TextStyle(color: Colors.white),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Comentários",
                              style: TextStyle(
                                  fontFamily: 'Circe',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: controllerComentario,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                user.email == ""
                                    ? _showErrorDialog(context)
                                    : await comentar(
                                        widget.ideia.idPostagem,
                                        user.idUsuarioWeb,
                                        controllerComentario.text);
                                setState(() {});
                              },
                              icon: Icon(Icons.send),
                            ),
                            labelText: "Deixe seu comentário!",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),

                      //ListView De Comentarios
                      listaComentarios.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 300,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all()),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(),
                                            Text(
                                              listaComentarios[index].nomeWeb,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            user.idUsuarioWeb ==
                                                    listaComentarios[index]
                                                        .idUsuarioWeb
                                                ? IconButton(
                                                    onPressed: () {
                                                      //deletarComentario();
                                                      PostComentario()
                                                          .deletarComentario(
                                                              widget.ideia
                                                                  .idPostagem,
                                                              user.idUsuarioWeb,
                                                              listaComentarios[
                                                                      index]
                                                                  .comentario);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Comentario excluido com sucesso!"),
                                                          duration: Duration(
                                                              seconds: 2),
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                        Text(
                                          listaComentarios[index].comentario,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: countComentarios,
                            )
                          : Center(
                              child: Text("Nenhum Comentario"),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            WidgetBottomAppBar(scaffoldKey: _scaffoldKey)
          ],
        ),
      ),
    );
  }

  List<Widget> gerarEstrelaColorida(double n) {
    List<Widget> avaliacao = [];
    int numeroEstrelas = n.floor(); // Arredonda para baixo
    for (int i = 0; i < numeroEstrelas; i++) {
      avaliacao.add(Icon(
        Icons.star,
        color: Colors.orange,
        size: 25,
      ));
    }
    return avaliacao;
  }

  List<Widget> gerarEstrelaNColorida(double n) {
    List<Widget> avaliacao = [];
    for (int i = 0; i < n; i++) {
      avaliacao.add(Icon(
        Icons.star_border,
        color: Colors.orange,
        size: 25,
      ));
    }
    return avaliacao;
  }

  /* List<Widget> materiais() {
    List<Widget> lista = [];
    widget.listaMateriais.forEach((String m) {
      lista.add(Text(
        "- " + m,
        style: TextStyle(
          fontFamily: 'Nunito',
        ),
      ));
    });
    return lista;
  } */
}
