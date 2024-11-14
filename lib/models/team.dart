class Team {
  String nome = "";
  String funcao = "";
  String textao = "";
  String imgUrl = "";

  Team(this.nome, this.funcao, this.textao, this.imgUrl);
  
  get getImgUrl => this.imgUrl;

 set setImgUrl( imgUrl) => this.imgUrl = imgUrl;

 String get getNome => this.nome;

 set setNome(String nome) => this.nome = nome;

  get getFuncao => this.funcao;

 set setFuncao( funcao) => this.funcao = funcao;

  get getTextao => this.textao;

 set setTextao( textao) => this.textao = textao;
}