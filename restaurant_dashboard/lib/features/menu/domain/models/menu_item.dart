import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final bool isAvailable;
  final String? description;
  final String? imageUrl;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.isAvailable,
    this.description,
    this.imageUrl,
  });

  MenuItem copyWith({
    String? id,
    String? restaurantId,
    String? name,
    double? price,
    bool? isAvailable,
    String? description,
    String? imageUrl,
  }) {
    return MenuItem(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    name,
    price,
    isAvailable,
    description,
    imageUrl,
  ];
}
