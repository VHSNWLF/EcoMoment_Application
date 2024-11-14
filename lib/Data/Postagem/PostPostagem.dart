// ignore_for_file: unnecessary_brace_in_string_interps, prefer_is_empty

import 'dart:io';

import 'package:ecomoment_application/Data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class PostPostagem{
  Dados dados = Dados();

  Future<void> avaliarIdeia(int idUsuarioWeb, int idPostagem, int valor, String nomeUsuarioDono) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/avaliacao/avaliar/${idUsuarioWeb}/${idPostagem}/${valor}/${nomeUsuarioDono}");
    http.Response response = await http.post(url);
    if(response.statusCode == 200){
      print("Ideia avaliada com sucesso!");
    }else{
      print("Erro ao avaliar ideia");
    }
    }catch(e){
      print("Erro na requisição: $e");
    }
  }
    Future<void> reavaliarIdeia(int idUsuarioWeb, int idPostagem, int valor, String nomeUsuarioDono) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/avaliacao/reavaliar/${idUsuarioWeb}/${idPostagem}/${valor}/${nomeUsuarioDono}");
    http.Response response = await http.post(url);
    if(response.statusCode == 200){
      print("Ideia avaliada com sucesso!");
    }else{
      print("Erro ao avaliar ideia");
    }
    }catch(e){
      print("Erro na requisição: $e");
    }
  }

  Future<void> excluirIdeia(int idPostagem, int idUsuarioWeb) async{
    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/deletePostagem/${idPostagem}/${idUsuarioWeb}");
    http.Response response = await http.post(url);
    if(response.statusCode == 200){
      print("Ideia excluida com sucesso!");
    }else{
      print("Erro ao excluir ideia");
    }
    }catch(e){
      print("Erro na requisição excluirIdeia: $e");
    }
  }

  Future<void> publicar(String nomeIdeia, String nomeUsuario, int tipoMaterial, String descricao, String materiaisNecessarios, String passoPasso, String dificuldade, List<XFile> imageFiles, List<String> tipo) async{

  // Converta cada XFile em Base64
  List<String> imagensBase64 = [];

  for (XFile image in imageFiles) {
    // Ler a imagem como bytes
    final bytes = await File(image.path).readAsBytes();
    // Codificar em Base64
    final String base64Image = base64Encode(bytes);
    imagensBase64.add(base64Image);
  }


    try{
      var url = Uri.parse("http://${dados.ipMaquina}:${dados.porta}/Ecomoment/postagem/publicarIdeia");
    http.Response response = await http.post(url,body: {
      'nomePostagem': nomeIdeia,
      'nomeUsuario': nomeUsuario,
      'desc': descricao,
      'matNecessarios': materiaisNecessarios,
      'passoPasso': passoPasso,
      'tipoMaterial': tipoMaterial.toString(),
      'dificuldade': dificuldade,
      
      // Adicione as imagens codificadas
      'img1': imagensBase64.length > 0 ? imagensBase64[0] : '',
      'tipo1': tipo.length > 0 ? tipo[0] : '',
      'img2': imagensBase64.length > 1 ? imagensBase64[1] : '',
      'tipo2': tipo.length > 1 ? tipo[1] : '',
      'img3': imagensBase64.length > 2 ? imagensBase64[2] : '',
      'tipo3': tipo.length > 2 ? tipo[2] : '',
      'img4': imagensBase64.length > 3 ? imagensBase64[3] : '',
      'tipo4': tipo.length > 3 ? tipo[3] : '',
      'img5': imagensBase64.length > 4 ? imagensBase64[4] : '',
      'tipo5': tipo.length > 4 ? tipo[4] : '',
      'img6': imagensBase64.length > 5 ? imagensBase64[5] : '',
      'tipo6': tipo.length > 5 ? tipo[5] : '',
      'img7': imagensBase64.length > 6 ? imagensBase64[6] : '',
      'tipo7': tipo.length > 6 ? tipo[6] : '',
      'img8': imagensBase64.length > 7 ? imagensBase64[7] : '',
      'tipo8': tipo.length > 7 ? tipo[7] : '',
      'img9': imagensBase64.length > 8 ? imagensBase64[8] : '',
      'tipo9': tipo.length > 8 ? tipo[8] : '',
      'img10': imagensBase64.length > 9 ? imagensBase64[9] : '',
      'tipo10': tipo.length > 9 ? tipo[9] : '',
    });
    if(response.statusCode == 200){
      print("Ideia publicada com sucesso!");
    }else{
      print("Erro ao publicar ideia");
  print("nomePostagem: $nomeIdeia");
  print("nomeUsuario: $nomeUsuario");
  print("desc: $descricao");
  print("matNecessarios: $materiaisNecessarios");
  print("passoPasso: $passoPasso");
  print("tipoMaterial: ${tipoMaterial.toString()}");
  print("dificuldade: $dificuldade");
  
  // Adicionando prints para as imagens
  for (int i = 0; i < 10; i++) {
    String imgKey = 'img${i + 1}';
    if (i < imagensBase64.length) {
      print("$imgKey: ${imagensBase64[i]}");
    } else {
      print("$imgKey: '' (nenhuma imagem)");
    }
  }
    }
    }catch(e){
      print("Erro na requisição publicar: $e");
    }
  }



}