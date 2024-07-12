import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/peoduct/service/product_service.dart'; // Make sure to import your correct product service

class AddProductScreen extends StatefulWidget {
  final Function(ProductModel) onAdd;

  const AddProductScreen({required this.onAdd});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController(); // New controller for category
  bool isLoading = false;
  String errorMessage = '';

  void addProduct() async {
    final String name = nameController.text.trim();
    final String description = descriptionController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());
    final String category = categoryController.text.trim(); // Fetch category from controller

    if (name.isNotEmpty && description.isNotEmpty && price != null && category.isNotEmpty) {
      final newProduct = ProductModel(
        id: '',
        name: name,
        description: description,
        price: price,
        category: category, // Assign category to new product
      );

      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      try {
        print('Sending request to add product: $newProduct');
        await ProductService.addProduct(newProduct); // Make sure ProductService handles adding products correctly
        print('Product added successfully');
        widget.onAdd(newProduct);
        Navigator.pop(context);
      } catch (e) {
        print('Error occurred while adding product: $e');
        setState(() {
          errorMessage = 'Failed to add product: $e';
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Product Description'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Product Price'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Product Category'), // New TextField for category
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: addProduct,
              child: const Text('Add Product'),
            ),
            if (errorMessage.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
