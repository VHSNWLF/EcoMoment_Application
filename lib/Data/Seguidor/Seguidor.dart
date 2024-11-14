// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'package:ecomoment_application/Data/Seguidor/GetSeguidor.dart';
import 'package:ecomoment_application/Data/Seguidor/PostSeguidor.dart';

class Seguidor{
  late GetSeguidor getSeguidor;
  late PostSeguidor postSeguidor;

  Seguidor(){
    this.getSeguidor = GetSeguidor();
    this.postSeguidor = PostSeguidor();
  }
}