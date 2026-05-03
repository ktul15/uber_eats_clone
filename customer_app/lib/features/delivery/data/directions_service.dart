import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:customer_app/shared/constants/api_keys.dart';

class DirectionsResult {
  final List<LatLng> routePoints;
  final int etaMinutes;
  final LatLng destination;

  const DirectionsResult({
    required this.routePoints,
    required this.etaMinutes,
    required this.destination,
  });
}

class DirectionsService {
  final Dio _dio;

  DirectionsService(this._dio);

  Future<DirectionsResult?> getDirections({
    required double originLat,
    required double originLng,
    required String destinationAddress,
  }) async {
    try {
      final response = await _dio.get(
        '/maps/api/directions/json',
        queryParameters: {
          'origin': '$originLat,$originLng',
          'destination': destinationAddress,
          'mode': 'driving',
          'key': ApiKeys.googleMapsApiKey,
        },
      );

      final data = response.data as Map<String, dynamic>;
      if (data['status'] != 'OK') return null;

      final routes = data['routes'] as List?;
      if (routes == null || routes.isEmpty) return null;

      final route = routes[0] as Map<String, dynamic>;
      final leg = (route['legs'] as List)[0] as Map<String, dynamic>;

      final encodedPolyline =
          (route['overview_polyline'] as Map<String, dynamic>)['points'] as String;
      final etaSeconds =
          (leg['duration'] as Map<String, dynamic>)['value'] as int;
      final endLocation = leg['end_location'] as Map<String, dynamic>;

      return DirectionsResult(
        routePoints: _decodePolyline(encodedPolyline),
        etaMinutes: (etaSeconds / 60).ceil(),
        destination: LatLng(
          (endLocation['lat'] as num).toDouble(),
          (endLocation['lng'] as num).toDouble(),
        ),
      );
    } catch (_) {
      return null;
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    final result = <LatLng>[];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < encoded.length) {
      int shift = 0;
      int resultVal = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        resultVal |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (resultVal & 1) != 0 ? ~(resultVal >> 1) : (resultVal >> 1);

      shift = 0;
      resultVal = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        resultVal |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (resultVal & 1) != 0 ? ~(resultVal >> 1) : (resultVal >> 1);

      result.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return result;
  }
}
