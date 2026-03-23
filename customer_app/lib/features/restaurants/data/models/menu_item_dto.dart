import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_dto.freezed.dart';
part 'menu_item_dto.g.dart';

@freezed
abstract class MenuItemDto with _$MenuItemDto {
  const factory MenuItemDto({
    required String id,
    required String restaurantId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required bool isAvailable,
  }) = _MenuItemDto;

  factory MenuItemDto.fromJson(Map<String, dynamic> json) =>
      _$MenuItemDtoFromJson(json);
}
