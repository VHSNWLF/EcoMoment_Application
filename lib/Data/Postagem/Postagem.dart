import 'package:ecomoment_application/Data/Postagem/GetPostagem.dart';
import 'package:ecomoment_application/Data/Postagem/PostPostagem.dart';

class Postagem{
  late GetPostagem getPostagem;
  late PostPostagem postPostagem;

  Postagem(){
    this.getPostagem = GetPostagem();
    this.postPostagem = PostPostagem();
  }
}