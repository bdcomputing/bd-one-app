class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String? icon;
  final String link;
  final String? image;
  final String? slug;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    this.icon,
    required this.link,
    this.image,
    this.slug,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
      link: json['link'] as String,
      image: json['image'] as String?,
      slug: json['slug'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'link': link,
      'image': image,
      'slug': slug,
    };
  }
}
