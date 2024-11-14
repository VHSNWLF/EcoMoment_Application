// ignore_for_file: unnecessary_this, non_constant_identifier_names, unnecessary_new, avoid_print, unused_import, unnecessary_string_interpolations, invalid_required_positional_param


import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Pessoa{
  int idUsuarioWeb = 0;
  String username = "";
  String email = "";
  String senha = "";
  String biografia = "";

  Uint8List? fotoPerfil;
  int qtdeSeguidores = 0;
  int qtdeSeguindo = 0;
  int qtdeCurtidas = 0;
  int qtdePostagens = 0;
  int ativo = 0;
  double reputacao = 0;


  Pessoa(
   this.username,
   this.email, 
   this.senha,
  );

  Pessoa.full(
   this.username,
   this.email, 
   this.senha,
);

  Pessoa.fromJson(Map<String, dynamic> json)
  :
  idUsuarioWeb = json['idUsuarioWeb'] ?? "",
  username = json['nomeWeb'] ?? "",
  email = json['emailWeb'] ?? "",
  senha = json['senhaWeb'] ?? "",
  biografia = json['biografia'] ?? "Sem biografia no momento.",
  qtdeSeguidores = json['qtdeSeguidores'] ?? "",
  qtdeSeguindo = json['qtdeSeguindo'] ?? "",
  qtdeCurtidas = json['qtdeCurtidas'] ?? "",
  qtdePostagens = json['qtdePostagens'] ?? "",
  reputacao = json['reputacao'] ?? "",
  ativo = json['ativo'] ?? "",
  fotoPerfil = (json['fotoPerfil'] != null && json['fotoPerfil'] != 'W10=')
    ? base64Decode(json['fotoPerfil']) 
    : null;
  

  Pessoa.n();

String get getBiografia => this.biografia;

 set setBiografia(String biografia) => this.biografia = biografia;

   Uint8List? get getFotoPerfil => this.fotoPerfil;

 set setFotoPerfil(Uint8List fotoPerfil) => this.fotoPerfil = fotoPerfil;

get getIdUsuarioWeb => this.idUsuarioWeb;

 set setIdUsuarioWeb( idUsuarioWeb) => this.idUsuarioWeb = idUsuarioWeb;

  get getUsername => this.username;

 set setUsername( username) => this.username = username;

  get getEmail => this.email;

 set setEmail( email) => this.email = email;

  get getSenha => this.senha;

 set setSenha( senha) => this.senha = senha;

  get getQtdeSeguidores => this.qtdeSeguidores;

 set setQtdeSeguidores( qtdeSeguidores) => this.qtdeSeguidores = qtdeSeguidores;

  get getQtdeSeguindo => this.qtdeSeguindo;

 set setQtdeSeguindo( qtdeSeguindo) => this.qtdeSeguindo = qtdeSeguindo;

  get getQtdeCurtidas => this.qtdeCurtidas;

 set setQtdeCurtidas( qtdeCurtidas) => this.qtdeCurtidas = qtdeCurtidas;

  get getQtdePostagens => this.qtdePostagens;

 set setQtdePostagens( qtdePostagens) => this.qtdePostagens = qtdePostagens;

  get getAtivo => this.ativo;

 set setAtivo( ativo) => this.ativo = ativo;

  get getReputacao => this.reputacao;

 set setReputacao( reputacao) => this.reputacao = reputacao;
  
}