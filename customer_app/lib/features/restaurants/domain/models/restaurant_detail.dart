import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customer_app/features/restaurants/domain/models/menu_item.dart';

part 'restaurant_detail.freezed.dart';

@freezed
abstract class RestaurantDetail with _$RestaurantDetail {
  const factory RestaurantDetail({
    required String id,
    required String name,
    String? description,
    required String address,
    double? lat,
    double? lng,
    String? imageUrl,
    required bool isActive,
    required double rating,
    required List<MenuItem> menuItems,
  }) = _RestaurantDetail;
}
