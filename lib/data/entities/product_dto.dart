class ProductDTO{
  int? id;
  String productName;
  String storeName;
  double price;
  int categoryId;
  List<String> images;

  ProductDTO({required this.price,required this.categoryId,required this.productName,
    required this.storeName,
    this.id,
    required this.images
  });
}