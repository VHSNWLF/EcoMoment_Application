// ignore_for_file: unnecessary_this

import 'package:ecomoment_application/Data/Curtida/GetCurtida.dart';
import 'package:ecomoment_application/Data/Curtida/PostCurtida.dart';

class Curtida{
  late GetCurtida getCurtida;
  late PostCurtida postCurtida;

  Curtida(){
    this.getCurtida = GetCurtida();
    this.postCurtida = PostCurtida();
  }
}