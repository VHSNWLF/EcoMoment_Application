import 'GetUsuario.dart';
import 'PostUsuario.dart';

class Usuario{
  late GetUsuario getUsuario;
  late PostUsuario postUsuario;

  Usuario(){
    this.getUsuario = GetUsuario();
    this.postUsuario = PostUsuario();
  }
}