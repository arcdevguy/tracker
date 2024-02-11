// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import '../location/location_service.dart';

class LocationProvider extends ChangeNotifier {
  bool _isTracking = false;
  bool _permissionGranted = false;
  final _logs = <String>[];

  bool get isTracking => _isTracking;
  bool get permissionGranted => _permissionGranted;
  List<String> get logs => _logs;

  final LocationService locationService;
  LocationProvider({required this.locationService});

  Future<void> startTracking() async {
    try {
      locationService.init();

      final serviceEnabled = await locationService.checkServiceEnabled();
      if (!serviceEnabled) {
        logs.add('ERROR: location service not enabled');
        notifyListeners();
        return;
      }

      final permissionGranted = await locationService.requestLocationPermission();
      if (!permissionGranted) {
        logs.add('ERROR: location permission not granted');
        notifyListeners();
        return;
      }

      final backgroundEnabled = await locationService.enableBackgroundMode();
      if (!backgroundEnabled) {
        logs.add("ERROR: background mode not enabled - 'Allow all time'");
        notifyListeners();
        return;
      }

      // start listener
      locationService.listenToUpdates((lat, lon) {
        logs.add('isMoving: ??? - ($lat,$lon)');
        print('>>> isMoving: ??? - ($lat,$lon)');
      });

      _isTracking = true;
      _permissionGranted = true;
      notifyListeners();
    } catch (e) {
      print(e);
      logs.add('ERROR: $e');
      notifyListeners();
    }
  }

  void stopTracking() {
    locationService.stopListenToUpdates();
    _isTracking = false;
    logs.clear();
    notifyListeners();
  }
}
