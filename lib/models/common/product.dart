class Product {
  final String id;
  final String name;
  final String description;
  final String? logo;
  final String slug;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.logo,
    required this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      logo: json['logo'] as String?,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'slug': slug,
    };
  }
}
