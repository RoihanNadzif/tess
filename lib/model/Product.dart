class Product {
  final String productId;
  final String Name;
  final int Price;
  final String imageUrl;

  Product({
    required this.productId,
    required this.Name,
    required this.Price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List;

    return Product(
      productId: json['product_id'],
      Name: json['name'],
      Price: json['price'],
      imageUrl: images[0]['image_path'],
    );
  }
}
