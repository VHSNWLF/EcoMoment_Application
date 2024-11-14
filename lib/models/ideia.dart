// ignore_for_file: unnecessary_this

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Ideia {
  int idPostagem = 0;
  String nomePostagem = "";
  String nomeUsuario = "";
  int numeroCurtidas = 0;
  String desc = "";
  String passoPasso = "";
  Uint8List? img1;
  Uint8List? img2;
  Uint8List? img3;
  Uint8List? img4;
  Uint8List? img5;
  Uint8List? img6;
  Uint8List? img7;
  Uint8List? img8;
  Uint8List? img9;
  Uint8List? img10;
  String materiais = "";
  int materialPostagem = 0;
  int qtdeComentarios = 0;
  int qtdeAvaliacoesPostagem = 0;
  double avaliacao = 0;
  String dificuldade = "";

  

  Ideia.vazia();

  Ideia.full(
      this.idPostagem,
      this.nomePostagem,
      this.nomeUsuario,
      this.numeroCurtidas,
      this.desc,
      this.passoPasso,
      this.img1,
      this.img2,
      this.img3,
      this.img4,
      this.img5,
      this.img6,
      this.img7,
      this.img8,
      this.img9,
      this.img10,
      this.materiais,
      this.materialPostagem,
      this.qtdeComentarios,
      this.qtdeAvaliacoesPostagem,
      this.avaliacao,
      this.dificuldade);

  Ideia(this.nomePostagem, this.img1, this.dificuldade, this.avaliacao,
      this.desc, this.passoPasso, this.nomeUsuario, this.materiais);
  Ideia.n(
      this.nomePostagem,
      this.img1,
      this.dificuldade,
      this.avaliacao,
      this.desc,
      this.passoPasso,
      this.nomeUsuario,
      this.materiais,
      this.materialPostagem);
  Ideia.ti(this.nomePostagem, this.img1, this.dificuldade, this.avaliacao);
  Ideia.fromJson(Map<String, dynamic> json)
      : idPostagem = json['idPostagem'],
        nomePostagem = json['nomePostagem'],
        nomeUsuario = json['nomeUsuario'],
        desc = json['descricaoPostagem'],
        materiais = json['materiaisNecessariosPostagem'],
        materialPostagem = json['materialPostagem'],
        passoPasso = json['instrucoesPostagem'],
        img1 = json['midia1'] != null ? base64Decode(json['midia1']) : null,
        img2 = json['midia2'] != null ? base64Decode(json['midia2']) : null,
        img3 = json['midia3'] != null ? base64Decode(json['midia3']) : null,
        img4 = json['midia4'] != null ? base64Decode(json['midia4']) : null,
        img5 = json['midia5'] != null ? base64Decode(json['midia5']) : null,
        img6 = json['midia6'] != null ? base64Decode(json['midia6']) : null,
        img7 = json['midia7'] != null ? base64Decode(json['midia7']) : null,
        img8 = json['midia8'] != null ? base64Decode(json['midia8']) : null,
        img9 = json['midia9'] != null ? base64Decode(json['midia9']) : null,
        img10 = json['midia10'] != null ? base64Decode(json['midia10']) : null,
        numeroCurtidas = json['numeroCurtidas'],
        dificuldade = json['dificuldadePostagem'],
        qtdeAvaliacoesPostagem = json['qtdeAvaliacoesPostagem'],
        qtdeComentarios = json['qtdeComentarios'],
        avaliacao = json['avaliacaoPostagem'];

  int get getMaterialPostagem => this.materialPostagem;

  set setMaterial(int materialPostagem) => this.materialPostagem = materialPostagem;

  int get getIdPostagem => this.idPostagem;

  set setIdPostagem(int idPostagem) => this.idPostagem = idPostagem;

  get getNomePostagem => this.nomePostagem;

  set setNomePostagem(nomePostagem) => this.nomePostagem = nomePostagem;

  get getNomeUsuario => this.nomeUsuario;

  set setNomeUsuario(nomeUsuario) => this.nomeUsuario = nomeUsuario;

  get getNumeroCurtidas => this.numeroCurtidas;

  set setNumeroCurtidas(numeroCurtidas) => this.numeroCurtidas = numeroCurtidas;

  get getDesc => this.desc;

  set setDesc(desc) => this.desc = desc;

  get getPassoPasso => this.passoPasso;

  set setPassoPasso(passoPasso) => this.passoPasso = passoPasso;

  get getImg1 => this.img1;

 set setImg1( img1) => this.img1 = img1;

  get getImg2 => this.img2;

 set setImg2( img2) => this.img2 = img2;

  get getImg3 => this.img3;

 set setImg3( img3) => this.img3 = img3;

  get getImg4 => this.img4;

 set setImg4( img4) => this.img4 = img4;

  get getImg5 => this.img5;

 set setImg5( img5) => this.img5 = img5;

  get getImg6 => this.img6;

 set setImg6( img6) => this.img6 = img6;

  get getImg7 => this.img7;

 set setImg7( img7) => this.img7 = img7;

  get getImg8 => this.img8;

 set setImg8( img8) => this.img8 = img8;

  get getImg9 => this.img9;

 set setImg9( img9) => this.img9 = img9;

  get getImg10 => this.img10;

 set setImg10( img10) => this.img10 = img10;
 
  get getMateriais => this.materiais;

  set setMateriais(materiais) => this.materiais = materiais;

  get getQtdeComentarios => this.qtdeComentarios;

  set setQtdeComentarios(qtdeComentarios) =>
      this.qtdeComentarios = qtdeComentarios;

  get getQtdeAvaliacoesPostagem => this.qtdeAvaliacoesPostagem;

  set setQtdeAvaliacoesPostagem(qtdeAvaliacoesPostagem) =>
      this.qtdeAvaliacoesPostagem = qtdeAvaliacoesPostagem;

  get getAvaliacao => this.avaliacao;

  set setAvaliacao(avaliacao) => this.avaliacao = avaliacao;

   get getDificuldade => this.dificuldade;

  set setDificuldade(dificuldade) => this.dificuldade = dificuldade;
}
