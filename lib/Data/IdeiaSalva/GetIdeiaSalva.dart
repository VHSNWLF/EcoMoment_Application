import 'package:ecomoment_application/Data/dados.dart';
import 'package:ecomoment_application/models/ideia.dart';
import 'package:ecomoment_application/models/ideiaSalva.dart';
import 'package:ecomoment_application/repository/ideiaRepository.dart';
import 'package:ecomoment_application/repository/ideiaSalvaRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetIdeiaSalva{
  Dados dados = Dados();

  GetIdeiaSalva();

  Future<List<Ideia>> listaIdeiasSalvasByIdUsuarioWeb(int idUsuarioWeb) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/salvos/ByIdUsuarioWeb/${idUsuarioWeb}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      var url2 = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/ideiasByIdPostagem");
      http.Response response2 = await http.get(url2);
      if(response2.statusCode == 200){
        IdeiaRepository ideiaRepo = IdeiaRepository();
        List listaIdeiasSalvasByIdUsuario_ = jsonDecode(response2.body) as List;
        return ideiaRepo.listaIdeias = listaIdeiasSalvasByIdUsuario_.map((e) => Ideia.fromJson(e)).toList();
      }
    }
    return [];
  }

  Future<bool> isSaved(int idUsuarioWeb, int idPostagem) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/salvos/isSaved/${idUsuarioWeb}/${idPostagem}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty && response.body != "null"){
        /* print("ta salvo");
        print("IdUsuarioWeb: $idUsuarioWeb");
        print("IdPostagem: $idPostagem"); */
        return true;
      }else{
        /* print("não ta salvo");
        print("IdUsuarioWeb: $idUsuarioWeb");
        print("IdPostagem: $idPostagem"); */
        return false;
      }
    }
    return false;
    }catch(e){
      print("erro na requisição [isSaved, GetIdeiaSalva] - $e");
      return false;
    }
  }
}