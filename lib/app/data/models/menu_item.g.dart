// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: $enumDecode(_$MenuCategoryEnumMap, json['category']),
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': _$MenuCategoryEnumMap[instance.category]!,
      'quantity': instance.quantity,
    };

const _$MenuCategoryEnumMap = {
  MenuCategory.drinks: 'drinks',
  MenuCategory.starter: 'starter',
  MenuCategory.mainCourse: 'mainCourse',
};
