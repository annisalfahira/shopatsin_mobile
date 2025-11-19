import 'package:flutter/material.dart';
import 'package:shopatsin_mobile/models/shopatsin_item.dart';

class ProductDetailPage extends StatelessWidget {
  final ShopAtSinItem item;

  const ProductDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.thumbnail.isNotEmpty)
              Center(
                child: Image.network(
                  item.thumbnail,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Rp ${item.price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(item.category)),
                const SizedBox(width: 8),
                if (item.isFeatured)
                  const Chip(
                    avatar: Icon(Icons.star, size: 16),
                    label: Text('Featured'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text("Stock: ${item.stock}"),
            if (item.brand != null && item.brand!.isNotEmpty)
              Text("Brand: ${item.brand}"),
            Text("Rating: ${item.rating}"),
            if (item.dateAdded != null)
              Text(
                "Added: ${item.dateAdded!.toLocal().toString().split(' ').first}",
              ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(item.description),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Kembali ke daftar item"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
