import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/peoduct/service/product_service.dart';
import 'package:prod_tracker/peoduct/ui/add_product_screen.dart';
import 'package:prod_tracker/peoduct/ui/product_card_screen.dart';


class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService productService = ProductService();
  List<ProductModel> products = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      List<ProductModel> fetchedProducts = await ProductService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching products: $e';
        isLoading = false;
      });
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await ProductService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      setState(() {
        errorMessage = 'Error adding product: $e';
      });
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await ProductService.deleteProduct(productId);
      await fetchProducts();
    } catch (e) {
      setState(() {
        errorMessage = 'Error deleting product: $e';
      });
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await ProductService.updateProduct(product.id, product);
      await fetchProducts();
    } catch (e) {
      setState(() {
        errorMessage = 'Error editing product: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(
          errorMessage,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      )
          : products.isEmpty
          ? Center(
        child: Text('No products available', style: TextStyle(color: Colors.black)),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onDelete: () => deleteProduct(products[index].id),
            onEdit: (updatedProduct) => updateProduct(updatedProduct),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                onAdd: (ProductModel product) {
                  addProduct(product);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.green,
      ),
    );
  }
}
