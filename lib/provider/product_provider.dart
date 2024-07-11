import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> fetchedProducts = await _productService.fetchProducts();
      products = fetchedProducts;
      notifyListeners(); // Notify listeners when data changes
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productService.addProduct(product);
      await fetchProducts(); // Refresh products list after adding
    } catch (e) {
      print('Error adding product: $e');
      // Handle error as needed
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productService.deleteProduct(productId);
      await fetchProducts(); // Refresh products list after deletion
    } catch (e) {
      print('Error deleting product: $e');
      // Handle error as needed
    }
  }

// Add more methods for updating and editing products if needed
}
