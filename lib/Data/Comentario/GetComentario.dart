// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:ecomoment_application/Data/dados.dart';
import 'package:ecomoment_application/models/Comentarios.dart';
import 'package:ecomoment_application/repository/ComentarioRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetComentario{
  Dados dados = Dados();

  GetComentario();

    Future<List<Comentarios>> listaComentarios(int idPostagem) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/comentario/ByIdPostagem/${idPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
        ComentarioRepository comentarioRepo = ComentarioRepository();
        List listaComentarios = jsonDecode(response.body) as List;
        return comentarioRepo.listaComentarios = listaComentarios.map((e) => Comentarios.fromJson(e)).toList();
    }
    return [];
  }

  

}