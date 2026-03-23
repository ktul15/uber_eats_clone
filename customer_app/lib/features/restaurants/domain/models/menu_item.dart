import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';

@freezed
abstract class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String restaurantId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required bool isAvailable,
  }) = _MenuItem;
}
