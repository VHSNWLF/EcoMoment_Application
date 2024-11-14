// ignore_for_file: file_names, unnecessary_getters_setters, avoid_print

class Postagemm {
  String _nome = '';
  String _material = '';
  String _descricao = '';
  String _materiaisNec = '';
  String _instrucoes = '';
  String _dificuldade = '';

  Postagemm(this._nome, this._material, this._descricao, this._materiaisNec,
      this._instrucoes, this._dificuldade);

  void mostra() {
    print('POSTAGEM REALIZADA COM SUCESSO');
    print('Nome da ideia: $_nome');
    print('Material da ideia: $_material');
    print('Descrição da ideia: $_descricao');
    print('Materiais necessários: $_materiaisNec');
    print('Instruções da ideia: $_instrucoes');
    print('Dificuldade da ideia: $_dificuldade');
    print('-----------------------');
  }

  String get nome => _nome;

  set nome(String value) => _nome = value;

  get material => _material;

  set material(value) => _material = value;

  get descricao => _descricao;

  set descricao(value) => _descricao = value;

  get materiaisNec => _materiaisNec;

  set materiaisNec(value) => _materiaisNec = value;

  get instrucoes => _instrucoes;

  set instrucoes(value) => _instrucoes = value;

  get dificuldade => _dificuldade;

  set dificuldade(value) => _dificuldade = value;
}
