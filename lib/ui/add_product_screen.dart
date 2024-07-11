import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final productProvider = Provider.of<ProductProvider>(context, listen: false);
            productProvider.addProduct(ProductModel(
              id: 'new_id',
              name: 'New Product',
              description: 'Description of new product',
              price: 0.0,
              category: 'Uncategorized',
            ));
            Navigator.pop(context);
          },
          child: Text('Add Product'),
        ),
      ),
    );
  }
}