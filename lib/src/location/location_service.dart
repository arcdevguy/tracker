import 'dart:async';

abstract interface class LocationService {
  void init();

  /// location service enabled
  Future<bool> checkServiceEnabled();

  /// permission granted
  Future<bool> requestLocationPermission();

  /// background mode enabled
  Future<bool> enableBackgroundMode();

  /// location updates listener
  void listenToUpdates(void Function(double lat, double lon) callback);

  /// location updates
  void stopListenToUpdates();
}
