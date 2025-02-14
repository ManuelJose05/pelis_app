import 'dart:convert';

import 'package:pelis_app/models/credits_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences? _prefs;

  iniPrefs() async{
    _prefs = await SharedPreferences.getInstance();
  }

  String get ultimaRuta{
    return _prefs!.getString('ruta') ?? "home";
  }

  void setUltimaRuta(String valor){
    _prefs!.setString('ruta', valor);
  }

  void savePeliId(int id) {
    _prefs!.setInt('idPeli', id);
  }

  int getPeliId() {
    return _prefs!.getInt('idPeli')!;
  }

  void saveActor(String data) {
    _prefs!.setString('actor', data);
  }
  
  Cast getActor() {
    final data = _prefs!.getString('actor')!;
    Cast temp = Cast.fromPreferences(jsonDecode(data));
    return temp;
  }
  
}