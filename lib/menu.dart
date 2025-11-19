// lib/menu.dart

import 'package:flutter/material.dart';

import 'package:shopatsin_mobile/screens/product_list.dart';
import 'package:shopatsin_mobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  // home route khusus menu (beda dengan '/' yang dipakai login)
  static const String homeRoute = '/home';

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;
    if (width >= 900) {
      crossAxisCount = 3;
    } else if (width >= 600) {
      crossAxisCount = 2;
    }

    final buttons = [
      _MenuButtonData(
        label: 'All Products',
        icon: Icons.sports_soccer,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProductListPage(
                showOnlyMineInitial: false,
              ),
            ),
          );
        },
      ),
      _MenuButtonData(
        label: 'My Products',
        icon: Icons.shopping_bag,
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProductListPage(
                showOnlyMineInitial: true,
              ),
            ),
          );
        },
      ),
      _MenuButtonData(
        label: 'Add Product',
        icon: Icons.add_circle,
        backgroundColor: Colors.red,
        onPressed: () => Navigator.pushNamed(
          context,
          AddProductPage.routeName,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(title),
      ),
      drawer: const AppDrawer(
        currentRoute: MyHomePage.homeRoute,
        homeRoute: MyHomePage.homeRoute,
        addProductRoute: AddProductPage.routeName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to ShopAtSin!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a menu to view or add products.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossAxisCount == 1 ? 3.8 : 1.4,
                children: [
                  for (final button in buttons) _MenuButton(data: button),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButtonData {
  _MenuButtonData({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.data});

  final _MenuButtonData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: data.backgroundColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: data.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Icon(data.icon, size: 32, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  data.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  static const String routeName = '/add-product';

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _categoryFieldKey = GlobalKey<FormFieldState<String>>();
  final _featuredFieldKey = GlobalKey<FormFieldState<bool>>();

  final List<String> _categories = const [
    'Jersey',
    'Shoes',
    'Accessories',
    'Merchandise',
  ];

  String? _selectedCategory;
  bool? _isFeatured;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _thumbnailController.clear();
    _categoryFieldKey.currentState?.didChange(null);
    _featuredFieldKey.currentState?.didChange(null);
    setState(() {
      _selectedCategory = null;
      _isFeatured = null;
    });
  }

  void _showPreviewDialog() {
    final double price = double.parse(_priceController.text.trim());
    final Map<String, String> productData = {
      'Name': _nameController.text.trim(),
      'Price': price.toStringAsFixed(2),
      'Category': _selectedCategory!,
      'Thumbnail': _thumbnailController.text.trim(),
      'Description': _descriptionController.text.trim(),
      'Featured': (_isFeatured ?? false) ? 'Yes' : 'No',
    };

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product saved successfully'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final entry in productData.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('${entry.key}: ${entry.value}'),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetForm();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _showPreviewDialog();
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Add New Product'),
      ),
      drawer: const AppDrawer(
        currentRoute: AddProductPage.routeName,
        homeRoute: MyHomePage.homeRoute,
        addProductRoute: AddProductPage.routeName,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration('Product Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product name is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Product name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: _inputDecoration('Price (IDR)'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
                    }
                    final price = double.tryParse(value.trim());
                    if (price == null) {
                      return 'Price must be a number';
                    }
                    if (price <= 0) {
                      return 'Price must be greater than 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: _categoryFieldKey,
                  initialValue: _selectedCategory,
                  decoration: _inputDecoration('Category'),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() {
                    _selectedCategory = value;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _thumbnailController,
                  decoration: _inputDecoration('Product Thumbnail URL'),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Thumbnail URL is required';
                    }
                    final uri = Uri.tryParse(value.trim());
                    final isValidUrl =
                        uri != null && uri.hasAbsolutePath && uri.hasScheme;
                    if (!isValidUrl ||
                        !(uri.scheme == 'http' || uri.scheme == 'https')) {
                      return 'Enter a valid URL (must start with http/https)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: _inputDecoration('Product Description'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    if (value.trim().length < 10) {
                      return 'Description must be at least 10 characters';
                    }
                    if (value.trim().length > 300) {
                      return 'Description must be below 300 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<bool>(
                  key: _featuredFieldKey,
                  initialValue: _isFeatured,
                  decoration: _inputDecoration('Show as Highlight?'),
                  hint: const Text('Select highlight status'),
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Yes, highlight'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text("No, don't highlight"),
                    ),
                  ],
                  onChanged: (value) => setState(() {
                    _isFeatured = value;
                  }),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select the highlight status';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _handleSave,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
