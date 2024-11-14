import 'package:ecomoment_application/Data/IdeiaSalva/GetIdeiaSalva.dart';
import 'package:ecomoment_application/Data/IdeiaSalva/PostIdeiaSalva.dart';

class IdeiaSalvaData{
  late GetIdeiaSalva getIdeiaSalva;
  late PostIdeiaSalva postIdeiaSalva;

  IdeiaSalvaData(){
    this.getIdeiaSalva = GetIdeiaSalva();
    this.postIdeiaSalva = PostIdeiaSalva();
  }
}