import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart'; // This line is crucial!

@JsonSerializable()
class MenuItem {
  final String name;
  final double price;
  final MenuCategory category;
  int quantity;

  MenuItem({
    required this.name,
    required this.price,
    required this.category,
    this.quantity = 0,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  MenuItem copyWith({
    String? name,
    double? price,
    MenuCategory? category,
    int? quantity,
  }) {
    return MenuItem(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
}

enum MenuCategory { drinks, starter, mainCourse }
