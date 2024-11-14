// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/dados.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:ecomoment_application/repository/pessoaRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class PostUsuario{

  Dados dados = Dados();

  PostUsuario();

  Future<void> cadastrarPessoaEmailSenha(
      String username, String email, String password) async {
    var url = Uri.parse(
        "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/cadastrar/@${username}/${email}/${password}");
    http.Response response = await http.post(url);
    if (response.statusCode == 200) {
      print('Pessoa cadastrada com sucesso');
    } else {
      print('Erro ao cadastrar pessoa');
    }
  }

    Future<void> atualizarFotoAndNomeUsuarioAndSobreMim(String? foto, String nomeUsuario, String biografia, int id) async {
    var url = Uri.parse(
        "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/atualizarFotoNomeBio");
    http.Response response = await http.post(url, body: {
      'foto': foto,
      'nome': nomeUsuario,
      'bio': biografia,
      'id': id.toString(),
    });
    if (response.statusCode == 200) {
      print('Pessoa atualizada com sucesso [foto/nome/bio]');
    } else {
    }
  }

  Future<void> atualizarUsuario(Uint8List foto, String nome, String biografia, int idUsuarioWeb) async {
    Dados dados2 = Dados();

  final String base64Foto = base64Encode(foto); // Converter a imagem para base64
  
  final Map<String, dynamic> dados = {
    'foto': base64Foto,
    'nome': nome,
    'biografia': biografia,
    'idUsuarioWeb': idUsuarioWeb,
  };

  final response = await http.post(Uri.parse("http://192.168.3.115:8080/Ecomoment/usuario/atualizarFotoNomeBio"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(dados),
  );

  if (response.statusCode == 200) {
    // A atualização foi bem-sucedida
    print('Atualizado com sucesso!');
  } else {
    // Lidar com o erro
    print('Falha ao atualizar: ${response.body}');
  }
}

  Future<void> atualizarSenha(String senha, int id) async {
    var url = Uri.parse(
        "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/atualizarSenha/${senha}/${id}");
    http.Response response = await http.post(url);
    if (response.statusCode == 200) {
      print('Pessoa atualizada com sucesso [senha]');
    } else {
      print('Erro ao atualizar pessoa [senha]');
    }
  }

  Future<void> excluirConta(int id, String nome) async {
    var url = Uri.parse(
        "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/excluirConta/${id}/${nome}");
    http.Response response = await http.post(url);
    if (response.statusCode == 200) {
      print('Pessoa excluida com sucesso');
    } else {
      print('Erro ao excluir pessoa');
      print(id.toString());
      print(nome);
    }
  }
}