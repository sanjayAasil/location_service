import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';

import '../common/global.dart';
import '../data/db.dart';
import '../model/location_model.dart';

class LocationService {
  final _locationStreamController = StreamController<Position>.broadcast();
  Timer? _timer;

  // Stream for location updates
  Stream<Position> get locationStream => _locationStreamController.stream;

  Future<void> requestLocationPermission(BuildContext context) async {
    // Check if location permission is granted
    var status = await Permission.location.status;

    if (status.isGranted) {
      // Permission already granted
      if (context.mounted) {
        showToast(context, 'Location permission already granted');
      }
    } else if (status.isDenied) {
      // Request permission
      status = await Permission.location.request();

      if (status.isGranted) {
        if (context.mounted) {
          showToast(context, 'Location permission granted');
        }
      } else if (status.isPermanentlyDenied) {
        // The user selected "Don't ask again"

        if (context.mounted) {
          showToast(context, 'Location permission permanently denied. Open app settings');
        }
        openAppSettings();
      } else {
        if (context.mounted) {
          showToast(context, 'Location permission denied');
        }
      }
    }
  }

  // Start location updates every 30 seconds
  void startLocationUpdates() async {
    try {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        print('Chweckkkkkk stream ');
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _locationStreamController.add(position); // Add position to stream
        PrefManager().pref.setString(
              PrefKeys.locationKey,
              jsonEncode(
                LocationModel(
                  lat: position.latitude,
                  lng: position.longitude,
                  speed: position.speed,
                ).toJson(),
              ),
            );
      });
    } catch (e) {
      print('on start location servixe exception $e');
    }
  }

  // Stop the timer when location updates are no longer needed
  void stopLocationUpdates() {
    _timer?.cancel();
    _locationStreamController.close();
  }
}
