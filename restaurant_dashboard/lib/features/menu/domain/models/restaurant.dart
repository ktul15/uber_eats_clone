import 'package:equatable/equatable.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/menu_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final bool isActive;
  final String? description;
  final String? address;
  final double? lat;
  final double? lng;
  final String? imageUrl;
  final List<MenuItem> menuItems;

  const Restaurant({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.isActive,
    this.description,
    this.address,
    this.lat,
    this.lng,
    this.imageUrl,
    this.menuItems = const [],
  });

  Restaurant copyWith({
    String? id,
    String? ownerId,
    String? name,
    bool? isActive,
    String? description,
    String? address,
    double? lat,
    double? lng,
    String? imageUrl,
    List<MenuItem>? menuItems,
  }) {
    return Restaurant(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      imageUrl: imageUrl ?? this.imageUrl,
      menuItems: menuItems ?? this.menuItems,
    );
  }

  @override
  List<Object?> get props => [
    id,
    ownerId,
    name,
    isActive,
    description,
    address,
    lat,
    lng,
    imageUrl,
    menuItems,
  ];
}
