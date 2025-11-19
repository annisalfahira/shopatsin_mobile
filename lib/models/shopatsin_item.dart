// lib/models/shopatsin_item.dart

class ShopAtSinItem {
  final int id;
  final String name;
  final int price;
  final String description;
  final String thumbnail;
  final String category;
  final bool isFeatured;
  final int stock;
  final String? brand;
  final double rating;
  final DateTime? dateAdded;
  final bool isOwner;
  final String detailUrl;

  ShopAtSinItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.stock,
    required this.brand,
    required this.rating,
    required this.dateAdded,
    required this.isOwner,
    required this.detailUrl,
  });

  factory ShopAtSinItem.fromJson(Map<String, dynamic> json) {
    return ShopAtSinItem(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      thumbnail: (json['thumbnail'] ?? '') as String,
      category: json['category'] as String,
      isFeatured: json['is_featured'] as bool,
      stock: json['stock'] as int,
      brand: json['brand'] as String?,
      rating: (json['rating'] as num).toDouble(),
      dateAdded: json['date_added'] != null
          ? DateTime.parse(json['date_added'] as String)
          : null,
      isOwner: json['is_owner'] as bool,
      detailUrl: json['detail_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "brand": brand,
        "rating": rating,
        "date_added": dateAdded?.toIso8601String(),
        "is_owner": isOwner,
        "detail_url": detailUrl,
      };
}
