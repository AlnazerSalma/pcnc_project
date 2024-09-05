import 'package:pcnc/aa/features/category/domain/entity/category.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      image: image,
    );
  }
}

