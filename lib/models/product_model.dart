class Product {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
