import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:location_service/common/global.dart';

import '../service/location_service.dart';
import '../service/notification_service.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService locationService;
  final List<Position?> _positions = [];

  List<Position?> get positions => _positions;

  LocationProvider({required this.locationService});

  Future<void> startLocationUpdates() async {
    locationService.startLocationUpdates();
    locationService.locationStream.listen((Position position) {
      print('checkkkkk position in listen $position');
      _positions.add(position);
      notifyListeners(); // Notify listeners when location is updated
    });
  }

  void stopLocationUpdates() {
    locationService.stopLocationUpdates();
    notifyListeners();
  }
}
