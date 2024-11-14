// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:ecomoment_application/Data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PostCurtida{
  Dados dados = Dados();

  PostCurtida();

  Future<void> curtir(int idPostagem, int idUsuarioCurtiuPostagem, String nomeUsuarioDono) async{
    try{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/curtida/curtirFunction/${idPostagem}/${idUsuarioCurtiuPostagem}/${nomeUsuarioDono}");
    http.Response response = await http.post(url);
    if (response.statusCode == 200){
      print("Curtida com sucesso");
    }else{
      print("Erro em [curtir, PostCurtida]");
    }
    }catch(e){
      print("erro na requisição em [curtir, PostCurtida] - $e");
    }
  }

  Future<void> descurtir(int idPostagem, int idUsuarioCurtiuPostagem, String nomeUsuarioDono) async{
    try{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/curtida/descurtirFunction/${idPostagem}/${idUsuarioCurtiuPostagem}/${nomeUsuarioDono}");
    http.Response response = await http.post(url);
    if (response.statusCode == 200){
      print("Descurtida com sucesso");
    }else{
      print("Erro em [descurtir, PostCurtida]");
    }
    }catch(e){
      print("erro na requisição em [descurtir, PostCurtida] - $e");
    }
  }
}