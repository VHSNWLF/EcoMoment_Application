// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:ecomoment_application/Data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PostIdeiaSalva{
  Dados dados = Dados();
  PostIdeiaSalva();

  Future<void> salvarIdeia(int idUsuarioWeb, int idPostagem) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/salvos/save/${idUsuarioWeb}/${idPostagem}");
    http.Response response = await http.post(url);
    if(response.statusCode == 200){
      print("ideia salva");
      print("IdUsuarioWeb: $idUsuarioWeb");
      print("IdPostagem: $idPostagem");
    }else{
      print("erro ao salvar ideia");
      print("IdUsuarioWeb: $idUsuarioWeb");
      print("IdPostagem: $idPostagem");
    }
    }catch(e){
      print("erro na requisição [salvarIdeia, PostIdeiaSalva] - $e");
    }
  }

  Future<void> deleteIdeiaSalva(int idUsuarioWeb, int idPostagem) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/salvos/delete/${idUsuarioWeb}/${idPostagem}");
    http.Response response = await http.post(url);
    if(response.statusCode == 200){
      print("ideiaSalva deletada");
      print("IdUsuarioWeb: $idUsuarioWeb");
      print("IdPostagem: $idPostagem");
    }else{
      print("erro ao deletar ideiaSalva");
      print("IdUsuarioWeb: $idUsuarioWeb");
      print("IdPostagem: $idPostagem");
    }
    }catch(e){
      print("erro na requisição [deleteIdeiaSalva, PostIdeiaSalva] - $e");
    }
  }
}