import 'package:ecomoment_application/Data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PostSeguidor{
  Dados dados = Dados();
  PostSeguidor();

    Future<void> follow(String nomeWebOutroUsuarioSeguido, int meuIdUsuarioWebSeguidor) async{
    try{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/follow/$nomeWebOutroUsuarioSeguido/$meuIdUsuarioWebSeguidor");
    http.Response response = await http.post(url);
    if (response.statusCode == 200){
      print("follow com sucesso");
    }else{
      print("Erro em [follow, PostSeguidor]");
    }
    }catch(e){
      print("erro na requisição em [follow, PostSeguidor] - $e");
    }
  }

  Future<void> unfollow(String nomeWebOutroUsuarioSeguido, int meuIdUsuarioWebSeguidor) async{
    try{
    var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/seguidor/unfollow/$nomeWebOutroUsuarioSeguido/$meuIdUsuarioWebSeguidor");
    http.Response response = await http.post(url);
    if (response.statusCode == 200){
      print("unfollow com sucesso");
    }else{
      print("nomeWebOutroUsuarioSeguid0: " + nomeWebOutroUsuarioSeguido);
      print("MeuId: " + meuIdUsuarioWebSeguidor.toString());
      print("Erro em [unfollow, PostSeguidor]");
    }
    }catch(e){
      print("erro na requisição em [unfollow, PostSeguidor] - $e");
    }
  }
}