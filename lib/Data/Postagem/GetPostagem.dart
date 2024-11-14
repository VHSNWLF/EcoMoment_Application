// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/dados.dart';
import 'package:ecomoment_application/models/ideia.dart';
import 'package:ecomoment_application/repository/ideiaRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class GetPostagem{
  Dados dados = Dados();

  GetPostagem();

  Future<List<Ideia>> listaIdeiasByMaterialPostagem(int materialPostagem) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/byMaterialPostagem/${materialPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      IdeiaRepository ideiaRepo = IdeiaRepository();
      List listaIdeias_ = jsonDecode(response.body) as List;
      return ideiaRepo.listaIdeias = listaIdeias_.map((e) => Ideia.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ideia>> listaIdeiasMaisAvaliadas2(int materialPostagem) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/maisAvaliadas2/${materialPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      IdeiaRepository ideiaRepo = IdeiaRepository();
      List listaIdeias_ = jsonDecode(response.body) as List;
      return ideiaRepo.listaIdeias = listaIdeias_.map((e) => Ideia.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ideia>> listaIdeiasMaisCurtidas2(int materialPostagem) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/maisCurtidas/${materialPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      IdeiaRepository ideiaRepo = IdeiaRepository();
      List listaIdeias_ = jsonDecode(response.body) as List;
      return ideiaRepo.listaIdeias = listaIdeias_.map((e) => Ideia.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ideia>> listaIdeiasMaisDificuldade2(int materialPostagem) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/maisDificuldade/${materialPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      IdeiaRepository ideiaRepo = IdeiaRepository();
      List listaIdeias_ = jsonDecode(response.body) as List;
      return ideiaRepo.listaIdeias = listaIdeias_.map((e) => Ideia.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ideia>> listaIdeiasAll() async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      IdeiaRepository ideiaRepo = IdeiaRepository();
      List listaIdeias_ = jsonDecode(response.body) as List;
      return ideiaRepo.listaIdeias = listaIdeias_.map((e) => Ideia.fromJson(e)).toList();
    }
    return [];
  }

    Future<List<Ideia>> findIdeiaByNomeUsuario(String nomeUsuario) async{
    print(nomeUsuario);
    var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/byNomeUsuario/${nomeUsuario}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      List listaIdeia = jsonDecode(response.body) as List;
      IdeiaRepository ideiaRepo = IdeiaRepository();
      ideiaRepo.listaIdeias = listaIdeia.map((e) => Ideia.fromJson(e)).toList();
      return ideiaRepo.listaIdeias;
    }
    return [];
  }

      Future<List<Ideia>> findIdeiaByNomeUsuarioOrderByNCurtidas(String nomeUsuario) async{
    print(nomeUsuario);
    var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/ideiasByNomeWebOrderByNCurtidas/${nomeUsuario}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      List listaIdeia = jsonDecode(response.body) as List;
      IdeiaRepository ideiaRepo = IdeiaRepository();
      ideiaRepo.listaIdeias = listaIdeia.map((e) => Ideia.fromJson(e)).toList();
      return ideiaRepo.listaIdeias;
    }
    return [];
  }

  Future<List<Ideia>> listaIdeiasMaisCurtidas() async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/maisAvaliadas");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      IdeiaRepository ideiaRepo = IdeiaRepository();
      List listaIdeias_ = jsonDecode(response.body) as List;
      return ideiaRepo.listaIdeias = listaIdeias_.map((e) => Ideia.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ideia>> listaIdeiaSeguindo(int idSeguindo) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/ByIdSeguidor/${idSeguindo}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      var url2 = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/ByIdSeguindo");
      http.Response response2 = await http.get(url2);
      if(response2.statusCode == 200){
        var url3 = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/ideiasByNomeWeb");
        http.Response response3 = await http.get(url3);
        IdeiaRepository ideiaRepo = IdeiaRepository();
        List listaIdeiasSeguindo_ = jsonDecode(response3.body) as List;
        return ideiaRepo.listaIdeias = listaIdeiasSeguindo_.map((e) => Ideia.fromJson(e)).toList();
      }
    }
    return [];
  }

    Future<bool> isRated(int idUsuarioWeb, int idPostagem) async{
    try{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/avaliacao/isRated/${idPostagem}/${idUsuarioWeb}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty && response.body != "null"){
        return true;
      }else{
        return false;
      }
    }
    return false;
    }catch(e){
      print("erro na requisição [isRated, GetPostagem] - $e");
      return false;
    }
  }

      Future<int> valorAvaliacao(int idUsuarioWeb, int idPostagem) async{
    try{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/avaliacao/isRated/${idPostagem}/${idUsuarioWeb}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty && response.body != "null"){
        var dadosAPI = jsonDecode(response.body);
        int valor = dadosAPI['valor'];
        return valor;
      }else{
        return 0;
      }
    }
    return 0;
    }catch(e){
      print("erro na requisição [valorAvaliacao, GetPostagem] - $e");
      return 0;
    }
  }

  Future<Ideia> buscarIdeiaByNomePostagem(String nomePostagem) async{
    try {
      var url = Uri.parse(
          "http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/findByNomePostagem/${nomePostagem}");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Ideia ideia = Ideia.vazia();
        return ideia = Ideia.fromJson(jsonDecode(response.body));
      } else {
        print("[buscarIdeiaByNomePostagem] Erro StatusCode != 200. Status: ${response.statusCode}");
        return Ideia.vazia();
      }
    } catch (e) {
      print("[buscarIdeiaByNomePostagem] Catch - Erro: $e");
      return Ideia.vazia();
    }
  }

}