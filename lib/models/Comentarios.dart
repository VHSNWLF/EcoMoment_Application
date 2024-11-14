// ignore_for_file: unnecessary_this

class Comentarios{
  int idComentario = 0;
  String nomeWeb = "";
  String comentario = "";
  int idUsuarioWeb = 0;

  Comentarios();
  Comentarios.fromJson(Map<String, dynamic> json):
    idComentario = json['idComentario'],
    nomeWeb = json['nomeWeb'],
    comentario = json['comentario'],
    idUsuarioWeb = json['idUsuarioWeb']
    ;

int get getIdUsuarioWeb => this.idUsuarioWeb;

 set setIdUsuarioWeb(int idUsuarioWeb) => this.idUsuarioWeb = idUsuarioWeb;

 int get getIdComentario => this.idComentario;

 set setIdComentario(int idComentario) => this.idComentario = idComentario;

  get getNomeWeb => this.nomeWeb;

 set setNomeWeb( nomeWeb) => this.nomeWeb = nomeWeb;

  get getComentario => this.comentario;

 set setComentario( comentario) => this.comentario = comentario;


}