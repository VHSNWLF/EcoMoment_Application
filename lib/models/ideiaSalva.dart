class IdeiaSalva{
  int idPostagem = 0;
  int idUsuarioWeb = 0;

  IdeiaSalva();
  IdeiaSalva.fromJson(Map<String, dynamic> json):
  idPostagem = json["id"]["idPostagem"]
  ;

  int get getIdUsuarioWeb => this.idUsuarioWeb;

 set setIdUsuarioWeb(int idUsuarioWeb) => this.idUsuarioWeb = idUsuarioWeb;

 int get getIdPostagem => this.idPostagem;

 set setIdPostagem(int idPostagem) => this.idPostagem = idPostagem;

}