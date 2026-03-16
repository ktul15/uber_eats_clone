import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_dashboard/features/menu/data/models/menu_item_dto.dart';

part 'restaurant_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantDto extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String? description;
  final String? address;
  final double? lat;
  final double? lng;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MenuItemDto> menuItems;

  const RestaurantDto({
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    this.address,
    this.lat,
    this.lng,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.menuItems = const [],
  });

  factory RestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDtoToJson(this);

  @override
  List<Object?> get props => [
    id,
    ownerId,
    name,
    description,
    address,
    lat,
    lng,
    isActive,
    createdAt,
    updatedAt,
    menuItems,
  ];
}
