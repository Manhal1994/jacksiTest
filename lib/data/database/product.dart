import 'package:drift/drift.dart';

import 'category.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text()();
  TextColumn get storeName => text()();
  RealColumn get price => real()();
  IntColumn get categoryId => integer().references(Categories, #id)();
}