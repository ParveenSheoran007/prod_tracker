import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/peoduct/service/product_service.dart';



class ProductProvider extends ChangeNotifier {
  final ProductService apiService = ProductService();
  List<ProductService> products = [];

  Future<void> fetchProducts() async {
    try {
      List<ProductService> fetchedProducts = (await ProductService.fetchProducts()).cast<ProductService>();
      products = fetchedProducts;
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await ProductService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await ProductService.deleteProduct(productId );
      await fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

}