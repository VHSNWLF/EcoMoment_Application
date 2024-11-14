// ignore_for_file: unnecessary_this

import 'package:ecomoment_application/models/Comentarios.dart';

class ComentarioRepository{
  List<Comentarios> listaComentarios = [];
  
  ComentarioRepository();

  List<Comentarios> get getListaComentarios => this.listaComentarios;

 set setListaComentarios(List<Comentarios> listaComentarios) => this.listaComentarios = listaComentarios;
}