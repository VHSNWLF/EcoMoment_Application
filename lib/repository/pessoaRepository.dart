import 'package:ecomoment_application/models/pessoa.dart';

class PessoaRepository{
  List<Pessoa> listaPessoa = [];

  PessoaRepository();

 List<Pessoa> get getListaPessoa => this.listaPessoa;

 set setListaPessoa(List<Pessoa> listaPessoa) => this.listaPessoa = listaPessoa;


}