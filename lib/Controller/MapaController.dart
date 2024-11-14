/*import 'dart:async';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class MapaController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  StreamSubscription<Position>? positionStream;
  final LatLng _position = LatLng(-22.56196082542741, -47.423618846796515);
  final _mapsControllerNotifier = ValueNotifier<GoogleMapController?>(null);

  static MapaController get to => Get.find<MapaController>();

  get mapsController => _mapsControllerNotifier.value;
  get position => _position;

  onMapCreated(GoogleMapController gmc) async {
    _mapsControllerNotifier.value = gmc;
  }

  void watchPosition() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      if (position != null) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      }
    }, onError: (error) {
      Get.snackbar(
        'Erro!',
        error.toString(),
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error("Por favor, ative a localização no smartphone.");
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        return Future.error("É preciso habilitar a localização.");
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error("Habilite a localização nas configurações.");
    }

    // Se chegou aqui, tem permissão para acessar a localização
    return await Geolocator.getCurrentPosition();
  }

  getPosicao() async {
    try {
      final posicao = await _posicaoAtual();
      latitude.value = posicao.latitude;
      longitude.value = posicao.longitude;
      if (_mapsControllerNotifier.value != null) {
        _mapsControllerNotifier.value!.animateCamera(
            CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
      }
    } catch (e) {
      Get.snackbar(
        'Erro!',
        e.toString(),
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}*/