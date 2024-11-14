// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/dados.dart';
import 'package:ecomoment_application/models/ideia.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/models/pessoaProvider.dart';
import 'package:ecomoment_application/repository/ideiaRepository.dart';
import 'package:ecomoment_application/repository/pessoaRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class GetUsuario{
  Dados dados = Dados();

  GetUsuario();

    //Metodo para buscar Usuario a partir do email
  Future<Pessoa> buscarPessoaByEmail(String email) async {
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByEmail/${email}");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Pessoa usuario = Pessoa.n();
        return usuario = Pessoa.fromJson(jsonDecode(response.body));
      } else {
        print("[buscarPessoaByEmail] Erro StatusCode != 200. Status: ${response.statusCode}");
        return Pessoa.n();
      }
    } catch (e) {
      print("[buscarPessoaByEmail] Catch - Erro: $e");
      return Pessoa.n();
    }
  }

    Future<Pessoa> buscarPessoaByNomeWeb(String nomeWeb) async {
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByNomeWeb/${nomeWeb}");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Pessoa usuario = Pessoa.n();
        return usuario = Pessoa.fromJson(jsonDecode(response.body));
      } else {
        print("[buscarPessoaByNomeWeb] Erro StatusCode != 200. Status: ${response.statusCode}");
        return Pessoa.n();
      }
    } catch (e) {
      print("[buscarPessoaByEmail] Catch - Erro: $e");
      return Pessoa.n();
    }
  }

  Future<void> buscarPessoaByEmailAndSet(
      String email, BuildContext context) async {
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByEmail/${email}");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Pessoa usuario = Pessoa.n();
        usuario = Pessoa.fromJson(jsonDecode(response.body));
        UsuarioProvider user =
            Provider.of<UsuarioProvider>(context, listen: false);
        user.setUsuarioProvider(UsuarioProvider.fromPessoa(usuario));
        print(usuario.toString());
      } else {
        print("[buscarPessoaByEmailAndSet] Erro StatusCode != 200. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("[buscarPessoaByEmailAndSet] Catch - Erro: $e");
    }
  }

  Future<bool> verificaUsuarioExistente(String nome, String email) async {
    try {
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByNomeAndEmail/$nome/$email");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        PessoaRepository pRepo = PessoaRepository();
        List listaUsuarios = jsonDecode(response.body) as List;
        // Converte a lista JSON para uma lista de objetos Pessoa
        pRepo.listaPessoa = listaUsuarios.map((e) => Pessoa.fromJson(e)).toList();
        if (listaUsuarios.isEmpty) {
          print("[verificaUsuarioExistente] Nenhum usuário encontrado.");
          return false;
        } else {
          print(
              "[verificaUsuarioExistente] Usuários encontrados: ${listaUsuarios.toString()}");
          return true;
        }
      } else {
        print("[verificaUsuarioExistente] Erro StatusCode != 200. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("[verificaUsuarioExistente] Catch - Erro: $e");
    }
    return false; // Retorna false em caso de erro ou se o código não for 200
  }

  Future<bool> verificaUsuarioByEmailOrUsernameAndSenha(String emailOrUsername, String senha) async {
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByEmailOrUsernameAndSenha/${emailOrUsername}/${senha}");
      http.Response response = await http.get(url);
        Map<String, dynamic> dadosAPI = jsonDecode(response.body);
        if (response.body.isEmpty && response.body == "null") {
          return false;
        } else {
          Pessoa usuario_a = Pessoa.n();
          usuario_a = Pessoa.fromJson(dadosAPI);
          return true;
        }
    } catch (e, stackTrace) {
      print('Erro na requisição: $e');
      print('StackTrace: $stackTrace');
      return false;
    }
  }

  Future<bool> verificaUsuarioNomeWeb(String nomeUsuario) async {
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByNomeWeb/${nomeUsuario}");
      http.Response response = await http.get(url);
        if (response.body.isNotEmpty && response.body != "null") {
          print("achei");
          return true;
        } else {
          print("Nao achei");
          return false;
        }
    } catch (e, stackTrace) {
      print('Erro na requisição: $e');
      print('StackTrace: $stackTrace');
      return false;
    }
  }

    Future<bool> verificaUsuarioByEmailOrUsernameAndSenhaAndSet(String emailOrUsername, String senha, BuildContext context) async {
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/usuario/verificaUsuarioByEmailOrUsernameAndSenha/${emailOrUsername}/${senha}");
      http.Response response = await http.get(url);
        Map<String, dynamic> dadosAPI = jsonDecode(response.body);
        if (response.body.isEmpty && response.body == "null") {
          return false;
        } else {
          Pessoa usuario_a = Pessoa.n();
          usuario_a = Pessoa.fromJson(dadosAPI);
          UsuarioProvider user =
            Provider.of<UsuarioProvider>(context, listen: false);
        user.setUsuarioProvider(UsuarioProvider.fromPessoa(usuario_a));
          return true;
        }
    } catch (e, stackTrace) {
      print('Erro na requisição: $e');
      print('StackTrace: $stackTrace');
      return false;
    }
  }
}