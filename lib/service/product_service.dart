import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prod_tracker/api_end_point.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/model/add_product_model.dart';
import 'package:prod_tracker/model/update_product_model.dart';
import 'package:prod_tracker/model/delete_product_model.dart';

class ProductService {
  static Future<List<ProductModel>> fetchProducts() async {
    try {
      Uri uri = Uri.parse(ApiEndpoints.products);
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<ProductModel> productList = data
            .map((item) => ProductModel.fromMap(item))
            .toList();
        return productList;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<String> addProduct(AddProductModel addProductRequest) async {
    try {
      Uri uri = Uri.parse(ApiEndpoints.products);
      String mapStr = jsonEncode(addProductRequest.toMap());
      http.Response response = await http.post(uri, body: mapStr);

      if (response.statusCode == 201) {
        return 'Product added successfully';
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  static Future<String> updateProduct(String productId, UpdateProductModel updateProductRequest) async {
    try {
      Uri uri = Uri.parse('${ApiEndpoints.products}/$productId');
      String mapStr = jsonEncode(updateProductRequest.toMap());
      http.Response response = await http.put(uri, body: mapStr);

      if (response.statusCode == 200) {
        return 'Product updated successfully';
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  static Future<String> deleteProduct(String productId) async {
    try {
      Uri uri = Uri.parse('${ApiEndpoints.products}/$productId');
      http.Response response = await http.delete(uri);

      if (response.statusCode == 200) {
        // Assuming your server returns a message or confirmation upon successful deletion
        String body = response.body;
        var json = jsonDecode(body);
        DeleteProductModel deleteProductResponse = DeleteProductModel.fromJson(json);
        return 'Product deleted successfully';
      } else {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
