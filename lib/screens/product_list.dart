// lib/screens/product_list.dart

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopatsin_mobile/config.dart';
import 'package:shopatsin_mobile/models/shopatsin_item.dart';
import 'package:shopatsin_mobile/screens/product_detail.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({
    super.key,
    this.showOnlyMineInitial = false,
  });

  // dipakai kalau mau navigate via route name (optional)
  static const String routeName = '/products';

  final bool showOnlyMineInitial;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late bool _showOnlyMine;

  @override
  void initState() {
    super.initState();
    _showOnlyMine = widget.showOnlyMineInitial;
  }

  Future<List<ShopAtSinItem>> _fetchItems(CookieRequest request) async {
    final url = _showOnlyMine
        ? "$baseUrl/flutter/items/?filter=my"
        : "$baseUrl/flutter/items/";

    final response = await request.get(url);

    List<ShopAtSinItem> items = [];
    for (var item in response) {
      items.add(ShopAtSinItem.fromJson(item));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopAtSin Items'),
        actions: [
          Row(
            children: [
              const Text('My items'),
              Switch(
                value: _showOnlyMine,
                onChanged: (val) {
                  setState(() {
                    _showOnlyMine = val;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<ShopAtSinItem>>(
        future: _fetchItems(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada item di ShopAtSin.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(item: item),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.thumbnail.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.thumbnail,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                            ),
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Rp ${item.price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8,
                                children: [
                                  Chip(
                                    label: Text(item.category),
                                  ),
                                  if (item.isFeatured)
                                    const Chip(
                                      avatar: Icon(
                                        Icons.star,
                                        size: 16,
                                      ),
                                      label: Text('Featured'),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
