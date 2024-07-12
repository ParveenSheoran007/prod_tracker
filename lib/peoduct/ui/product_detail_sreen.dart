import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prod_tracker/model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          product.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Chip(
                  label: Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 24),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            SizedBox(height: 24),
            Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus urna ut risus sodales, eget congue sem lobortis. Proin eget posuere nisi, quis posuere felis.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {

    Fluttertoast.showToast(
    msg: "Order confirmed!",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 16.0,
    );
    },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
