import 'dart:async';
import 'package:flutter/foundation.dart';

class LocationCoordinate {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationCoordinate(this.latitude, this.longitude, this.timestamp);
}

class DeliveryLocationService {
  Timer? _locationTimer;
  final _locationController = StreamController<LocationCoordinate>.broadcast();
  
  bool _isTracking = false;
  
  // Dummy starting point near a campus location
  double _currentLat = 28.6139; 
  double _currentLng = 77.2090;

  Stream<LocationCoordinate> get locationStream => _locationController.stream;

  void startTracking() {
    if (_isTracking) return;
    _isTracking = true;

    _locationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Simulate small movement
      _currentLat += 0.0001;
      _currentLng += 0.0001;
      
      final coord = LocationCoordinate(_currentLat, _currentLng, DateTime.now());
      _locationController.add(coord);
      
      if (kDebugMode) {
        print('New Location Update: ${_currentLat.toStringAsFixed(6)}, ${_currentLng.toStringAsFixed(6)}');
      }
    });
  }

  void stopTracking() {
    _locationTimer?.cancel();
    _isTracking = false;
  }

  void updateCurrentLocation(double lat, double lng) {
    _currentLat = lat;
    _currentLng = lng;
    _locationController.add(LocationCoordinate(lat, lng, DateTime.now()));
  }

  void dispose() {
    stopTracking();
    _locationController.close();
  }
}
