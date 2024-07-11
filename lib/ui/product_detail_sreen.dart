import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                product.name,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Product ID:', product.id),
            const SizedBox(height: 15),
            _buildDetailRow('Description:', product.desc),
            const SizedBox(height: 15),
            _buildDetailRow('Price:', '\$${product.price.toStringAsFixed(2)}'),
            const SizedBox(height: 15),
            _buildDetailRow('Category:', product.category),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
