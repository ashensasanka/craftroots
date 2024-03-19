import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"price")
  double? price;

  @JsonKey(name:"rate")
  double? rate;

  @JsonKey(name:"level")
  String? level;

  @JsonKey(name:"description")
  String? description;

  @JsonKey(name:"category")
  String? category;

  @JsonKey(name:"imageUrl")
  String? imageUrl;


  Product({
    this.rate,
   this.id,
   this.name,
   this.category,
    this.price,
    this.level,
    this.imageUrl,
    this.description
});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

}