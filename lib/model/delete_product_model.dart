class DeleteProductModel {
  String? message;

  DeleteProductModel({this.message});

  DeleteProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}