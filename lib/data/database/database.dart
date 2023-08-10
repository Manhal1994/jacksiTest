import 'package:drift/drift.dart';
import 'package:jacksi_test/data/database/images.dart';
import 'package:jacksi_test/data/database/product.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:jacksi_test/images.dart';
import 'category.dart';
part 'database.g.dart';

@DriftDatabase(tables: [Categories, Products, Images])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await batch((batch) {
          batch.insertAll(categories, [
            const CategoriesCompanion(
                name: Value<String>("تصنيف 1"),
                image: Value(AppImages.categoryImg1)),
            const CategoriesCompanion(
                name: Value<String>("تصنيف 2"),
                image: Value(AppImages.categoryImg2)),
            const CategoriesCompanion(
                name: Value<String>("تصنيف 3"),
                image: Value(AppImages.categoryImg3))
          ]);
        });
      },
    );
  }

  Future<List<Category>> get allCategories async =>
      await select(categories).get();

  Future<bool> addProduct(ProductDTO productDTO) async {
    var result = await into(products).insert(ProductsCompanion(
        productName: Value<String>(productDTO.productName),
        storeName: Value<String>(productDTO.storeName),
        price: Value<double>(productDTO.price),
        categoryId: Value<int>(productDTO.categoryId)));
    await addProductImages(productDTO, result);
    return result > 0;
  }

  addProductImages(ProductDTO productDTO, int id) async {
    batch((batch) {
      batch.insertAll(
          images,
          productDTO.images.map((e) => ImagesCompanion(
              productId: Value<int>(id), path: Value<String>(e))));
    });
  }
  Stream<List<QueryRow>>  sds(){
    return customSelect(
      'SELECT products.product_name,products.store_name,products.category_id,products.id,products.price, GROUP_CONCAT(images.path) as path from products JOIN images ON products.id=images.product_id group by images.product_id',
    ).watch();
  }
  Future<List<ProductDTO>> getProducts() {
    return customSelect(
      'SELECT products.product_name,products.store_name,products.category_id,products.id,products.price, GROUP_CONCAT(images.path) as path from products JOIN images ON products.id=images.product_id group by images.product_id',
    ).map((element) {
      double price = element.read<double>('price');
      String name = element.read<String>('product_name');
      int categoryId = element.read<int>('category_id');
      String storeName = element.read<String>('store_name');
      List<String> images = element.read<String>('path').split(",");

      return ProductDTO(
          price: price,
          productName: name,
          categoryId: categoryId,
          storeName: storeName,
          images: images);
    }).get();

  }

  Future<List<ProductDTO>> getProductsByCategory(int categoryId) {
    return customSelect(
      'SELECT products.product_name,products.store_name,products.category_id,products.id,products.price, GROUP_CONCAT(images.path) as path from products JOIN images ON products.id=images.product_id where products.category_id=${categoryId} group by images.product_id',
    ).map((element) {
      double price = element.read<double>('price');
      String name = element.read<String>('product_name');
      int categoryId = element.read<int>('category_id');
      String storeName = element.read<String>('store_name');
      List<String> images = element.read<String>('path').split(",");

      return ProductDTO(
          price: price,
          productName: name,
          categoryId: categoryId,
          storeName: storeName,
          images: images);
    }).get();

  }

  Stream<List<Product>> allProducts(){
   return select(products).watch();
  }
}
