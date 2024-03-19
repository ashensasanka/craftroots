// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      rate: (json['rate'] as num?)?.toDouble(),
      id: json['id'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      level: json['level'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'rate': instance.rate,
      'level': instance.level,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
