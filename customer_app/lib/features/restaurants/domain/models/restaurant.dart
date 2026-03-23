import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant.freezed.dart';

@freezed
abstract class Restaurant with _$Restaurant {
  const factory Restaurant({
    required String id,
    required String name,
    String? description,
    required String address,
    double? lat,
    double? lng,
    String? imageUrl,
    required bool isActive,
    required double rating,
  }) = _Restaurant;
}
