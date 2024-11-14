// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:ecomoment_application/Data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostComentario{
  Dados dados = Dados();

  PostComentario();

  Future<void> comentar(int idPostagem, int idUsuarioWeb, String comentario) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/comentario/comentar/${idPostagem}/${idUsuarioWeb}/${comentario}");
      http.Response response = await http.post(url);
      if(response.statusCode == 200){
        print("Comentario com sucesso!");
      }else{
        print("Erro ao comentar ideia");
      }
    }catch(e){
      print("Erro na requisição[comentar]: $e");
    }
  }

  Future<void> deletarComentario(int idPostagem, int idUsuarioWeb, String comentario) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/comentario/deletarComentario/${idPostagem}/${idUsuarioWeb}/${comentario}");
      http.Response response = await http.post(url);
      if(response.statusCode == 200){
        print("Deletar Comentario com sucesso!");
      }else{
        print("Erro ao deletar comentar ideia");
      }
    }catch(e){
      print("Erro na requisição[deletarComent]: $e");
    }
  }
}