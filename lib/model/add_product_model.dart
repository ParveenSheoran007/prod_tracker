class AddProductModel {
  String name;
  String desc;
  int price;

  AddProductModel({
    required this.name,
    required this.desc,
    required this.price, required String category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': desc,
      'price': price,
    };
  }
}