import 'package:jacksi_test/data/database/database.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';

class Repository {
  final Database _db;
  Repository(this._db);

  Future<bool> addProduct(ProductDTO productDTO) async{
    return await _db.addProduct(productDTO);
  }

  Future<List<ProductDTO>>  getProducts() {
    return _db.getProducts();
  }

  Future<List<ProductDTO>>  getProductsByCategory(int categoryId) {
    return _db.getProductsByCategory(categoryId);
  }

  Future<List<Category>> getCategories() async{
   return await _db.allCategories;
  }

  Stream<List<Product>> allProducts(){
  return  _db.allProducts();
  }

}
