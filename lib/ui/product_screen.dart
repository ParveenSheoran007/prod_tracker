import 'package:flutter/material.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/provider/product_provider.dart';
import 'package:prod_tracker/ui/edit_product_screen.dart';
import 'package:prod_tracker/ui/product_detail_sreen.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.products.isEmpty) {
              return Center(child: Text('No products available.'));
            }

            return ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                ProductModel product = provider.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.desc),
                  onTap: () => _navigateToProductDetail(context, product),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            _navigateToEditScreen(context, product),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _deleteProduct(context, provider, product),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToEditScreen(context, null),
          // Null indicates new product
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, ProductModel? product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: product),
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  void _deleteProduct(
      BuildContext context, ProductProvider provider, ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${product.name}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await provider.deleteProduct(product.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
