import 'package:ecomoment_application/models/ideiaSalva.dart';

class IdeiaSalvaRepository{
  List<IdeiaSalva> listaIdeiaSalva = [];

  IdeiaSalvaRepository();

  List<IdeiaSalva> get getListaIdeiaSalva => this.listaIdeiaSalva;

 set setListaIdeiaSalva(List<IdeiaSalva> listaIdeiaSalva) => this.listaIdeiaSalva = listaIdeiaSalva;
}