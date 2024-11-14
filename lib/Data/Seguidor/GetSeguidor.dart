// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:ecomoment_application/Data/dados.dart';
import 'package:ecomoment_application/models/pessoa.dart';
import 'package:ecomoment_application/repository/pessoaRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetSeguidor{
  Dados dados = Dados();
  GetSeguidor();

  Future<List<Pessoa>> listaUsuariosSeguindo(int idUsuarioWeb) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/verSeguindo/${idUsuarioWeb}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
        PessoaRepository pessoaRepo = PessoaRepository();
        List listaUsuariosSeguindo = jsonDecode(response.body) as List;
        return pessoaRepo.listaPessoa = listaUsuariosSeguindo.map((e) => Pessoa.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Pessoa>> listaUsuariosSeguidores(int idUsuarioWeb) async{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/verSeguidores/${idUsuarioWeb}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
        PessoaRepository pessoaRepo = PessoaRepository();
        List listaUsuariosSeguindo = jsonDecode(response.body) as List;
        return pessoaRepo.listaPessoa = listaUsuariosSeguindo.map((e) => Pessoa.fromJson(e)).toList();
    }
    return [];
  }

    Future<bool> isFollower(int meuIdUsuarioWeb, int usuarioIdSeguido) async {
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/isFollower/${meuIdUsuarioWeb}/${usuarioIdSeguido}");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      if (response.body.isNotEmpty && response.body != "null") {
      print("Achei");
      print("meuIdUsuarioWeb: ${meuIdUsuarioWeb}");
      print("usuarioIdSeguido: ${usuarioIdSeguido}");
      print(response.body);
      return true;
    }else{
        print("não achei");
        print("meuIdUsuarioWeb: ${meuIdUsuarioWeb}");
        print("usuarioIdSeguido: ${usuarioIdSeguido}");
        print(response.body);
        return false;
      }
    }
    return false;
  }

}