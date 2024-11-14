// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:ecomoment_application/Data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class GetCurtida{

  Dados dados = Dados();
  GetCurtida();

  Future<bool> isFavorited(int idUsuarioWeb, int idPostagem) async {
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/curtida/isFavorited/${idUsuarioWeb}/${idPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      if (response.body.isNotEmpty && response.body != "null") {
      /* print("Achei");
      print("idUsuarioWeb: ${idUsuarioWeb}");
      print("idPostagem: ${idPostagem}");
      print(response.body); */
      return true;
    }else{
        /* print("não achei");
        print("idUsuarioWeb: ${idUsuarioWeb}");
        print("idPostagem: ${idPostagem}");
        print(response.body); */
        return false;
      }
    }
    return false;
  }
}