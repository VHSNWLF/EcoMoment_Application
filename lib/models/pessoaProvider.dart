import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ecomoment_application/models/pessoa.dart';

class UsuarioProvider with ChangeNotifier {
  String _username = "";
  String _email = "";
  String _senha = "";
  Uint8List? _fotoPerfil;
  int _idUsuarioWeb = 0;
  int _qtdeSeguidores = 0;
  int _qtdeSeguindo = 0;
  int _qtdeCurtidas = 0;
  int _qtdePostagens = 0;
  int _ativo = 0;
  double _reputacao = 0;

  void incrementarQtdeSeguindo() {
    _qtdeSeguindo++;
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  void decrementarQtdeSeguindo() {
    _qtdeSeguindo--;
    notifyListeners();
  }

  // Getters
  String get username => _username;
  String get email => _email;
  String get senha => _senha;
  Uint8List? get fotoPerfil => _fotoPerfil;
  int get idUsuarioWeb => _idUsuarioWeb;
  int get qtdeSeguidores => _qtdeSeguidores;
  int get qtdeSeguindo => _qtdeSeguindo;
  int get qtdeCurtidas => _qtdeCurtidas;
  int get qtdePostagens => _qtdePostagens;
  int get ativo => _ativo;
  double get reputacao => _reputacao;

  // Construtor padrão
  UsuarioProvider();

  // Factory constructor para criar a partir de um objeto Pessoa
  factory UsuarioProvider.fromPessoa(Pessoa pessoa) {
    // Cria uma instância de UsuarioProvider
    UsuarioProvider usuarioProvider = UsuarioProvider();

    // Inicializa os valores com base em Pessoa
    usuarioProvider._username = pessoa.username;
    usuarioProvider._email = pessoa.email;
    usuarioProvider._senha = pessoa.senha;
    usuarioProvider._fotoPerfil = pessoa.fotoPerfil;
    usuarioProvider._idUsuarioWeb = pessoa.idUsuarioWeb;
    usuarioProvider._qtdeSeguidores = pessoa.qtdeSeguidores;
    usuarioProvider._qtdeSeguindo = pessoa.qtdeSeguindo;
    usuarioProvider._qtdeCurtidas = pessoa.qtdeCurtidas;
    usuarioProvider._qtdePostagens = pessoa.qtdePostagens;
    usuarioProvider._ativo = pessoa.ativo;
    usuarioProvider._reputacao = pessoa.reputacao;

    // Retorna a instância
    return usuarioProvider;
  }

  // Novo método para atualizar o provider com uma instância de UsuarioProvider
  void setUsuarioProvider(UsuarioProvider usuario) {
    _username = usuario._username;
    _email = usuario._email;
    _senha = usuario._senha;
    _fotoPerfil = usuario._fotoPerfil;
    _idUsuarioWeb = usuario._idUsuarioWeb;
    _qtdeSeguidores = usuario._qtdeSeguidores;
    _qtdeSeguindo = usuario._qtdeSeguindo;
    _qtdeCurtidas = usuario._qtdeCurtidas;
    _qtdePostagens = usuario._qtdePostagens;
    _ativo = usuario._ativo;
    _reputacao = usuario._reputacao;

    notifyListeners(); // Notifica que o estado foi alterado
  }

  // Métodos para atualizar o estado e notificar listeners
  void setReputacao(double reputacao) {
    _reputacao = reputacao;
    notifyListeners();
  }

  void setAtivo(int ativo) {
    _ativo = ativo;
    notifyListeners();
  }

  void setQtdePostagens(int qtdePostagens) {
    _qtdePostagens = qtdePostagens;
    notifyListeners();
  }

  void setQtdeCurtidas(int qtdeCurtidas) {
    _qtdeCurtidas = qtdeCurtidas;
    notifyListeners();
  }

  void setQtdeSeguidores(int qtdeSeguidores) {
    _qtdeSeguidores = qtdeSeguidores;
    notifyListeners();
  }

  void setQtdeSeguindo(int qtdeSeguindo) {
    _qtdeSeguindo = qtdeSeguindo;
    notifyListeners();
  }

  void setId(int id) {
    _idUsuarioWeb = id;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setSenha(String senha) {
    _senha = senha;
    notifyListeners();
  }
}
