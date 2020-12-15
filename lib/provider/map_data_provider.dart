import 'package:flutter/material.dart';

class MapDataProvider with ChangeNotifier {
  List<double> _SrcLatLng;
  List<double> _DestLatLng;

  MapDataProvider() {
    _SrcLatLng = [18.448625645318046, 73.88053105338318];
    _DestLatLng = [18.51810006856386, 73.81494697758525];
  }

  List<double> get src => _SrcLatLng;
  List<double> get dest => _DestLatLng;

  void setLatLng(List<double> src, List<double> dest) {
    _SrcLatLng = src;
    _DestLatLng = dest;
    notifyListeners();
  }
}
