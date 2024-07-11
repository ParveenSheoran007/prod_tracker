import 'package:flutter/material.dart';
import 'package:prod_tracker/model/add_product_model.dart';
import 'package:prod_tracker/model/product_model.dart';
import 'package:prod_tracker/model/update_product_model.dart';
import 'package:prod_tracker/provider/product_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel? product;

  const EditProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.desc;
      _priceController.text = widget.product!.price.toString();
      _categoryController.text = widget.product!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Product' : 'Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final product = ProductModel(
                        id: widget.product?.id ?? '',
                        name: _nameController.text,
                        desc: _descriptionController.text,
                        price: int.parse(_priceController.text),
                        category: _categoryController.text,
                      );

                      final provider = Provider.of<ProductProvider>(context, listen: false);
                      if (isEditMode) {
                        provider.updateProduct(product.id, product);
                      } else {
                        provider.addProduct(AddProductModel(
                          name: product.name,
                          desc: product.desc,
                          price: product.price,
                          category: product.category,
                        ) as ProductModel); // Add product
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditMode ? 'Update' : 'Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
