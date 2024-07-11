class ProductModel {
  String id;
  String name;
  String desc;
  int price;
  String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.category,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      name: map['name'],
      desc: map['description'],
      price: map['price'],
      category: map['category'],
    );
  }

  // Setter for description
  set description(String value) {
    desc = value;
  }
}
