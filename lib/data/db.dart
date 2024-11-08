import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/location_model.dart';

class PrefManager {
  static final PrefManager _instance = PrefManager._();

  PrefManager._();

  factory PrefManager() => _instance;
  late SharedPreferences pref;

  Future<LocationModel?> getLastLocation() async {
    final location = pref.getString(PrefKeys.locationKey);

    print('chjeckkkkk shared pref data $location');
    if (location == null) return null;

    return LocationModel.fromJson(jsonDecode(location));
  }
}

class PrefKeys {
  static const locationKey = 'location_key';
}
