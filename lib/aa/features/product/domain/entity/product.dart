
class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });
}
