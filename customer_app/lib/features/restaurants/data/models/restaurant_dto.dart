import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_dto.freezed.dart';
part 'restaurant_dto.g.dart';

@freezed
abstract class RestaurantDto with _$RestaurantDto {
  const factory RestaurantDto({
    required String id,
    required String name,
    String? description,
    required String address,
    double? lat,
    double? lng,
    String? imageUrl,
    required bool isActive,
    required double rating,
  }) = _RestaurantDto;

  factory RestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDtoFromJson(json);
}
