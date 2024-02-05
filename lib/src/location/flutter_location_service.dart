import 'dart:async';

import 'package:location/location.dart';

import 'location_service.dart';

class FlutterLocationService implements LocationService {
  Location? _location;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void init() {
    _location = Location();
  }

  @override
  Future<bool> checkServiceEnabled() async {
    bool serviceEnabled = await _location?.serviceEnabled() ?? false;
    if (!serviceEnabled) {
      serviceEnabled = await _location?.requestService() ?? false;
      if (!serviceEnabled) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  @override
  Future<bool> requestLocationPermission() async {
    final permissionGranted = await _location?.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      final permissionGranted = await _location?.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  @override
  Future<bool> enableBackgroundMode() async {
    final backgroundEnabled = await _location?.enableBackgroundMode() ?? false;
    if (!backgroundEnabled) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void listenToUpdates(void Function(double lat, double lon) callback) {
    _location?.onLocationChanged.listen((LocationData currentLocation) {
      final lat = currentLocation.latitude ?? 0;
      final lon = currentLocation.longitude ?? 0;
      callback(lat, lon);
      //TODO(LM): call api here
    });
  }

  @override
  void stopListenToUpdates() {
    _locationSubscription?.cancel();
  }
}
