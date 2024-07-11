import 'package:flutter/foundation.dart';
import 'package:prod_tracker/model/add_product_model.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/model/update_product_model.dart';
import 'package:prod_tracker/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;

  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();

      _products = await ProductService.fetchProducts();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      _isLoading = true;
      notifyListeners();

      await ProductService.addProduct(product as AddProductModel);

      await fetchProducts();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<void> updateProduct(String productId, ProductModel product) async {
    try {
      _isLoading = true;
      notifyListeners();

      await ProductService.updateProduct(
          productId, product as UpdateProductModel);

      await fetchProducts();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await ProductService.deleteProduct(productId);

      await fetchProducts();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }
}
