import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customer_app/features/restaurants/data/models/menu_item_dto.dart';

part 'restaurant_detail_dto.freezed.dart';
part 'restaurant_detail_dto.g.dart';

@freezed
abstract class RestaurantDetailDto with _$RestaurantDetailDto {
  const factory RestaurantDetailDto({
    required String id,
    required String name,
    String? description,
    required String address,
    double? lat,
    double? lng,
    String? imageUrl,
    required bool isActive,
    required double rating,
    required List<MenuItemDto> menuItems,
  }) = _RestaurantDetailDto;

  factory RestaurantDetailDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailDtoFromJson(json);
}
