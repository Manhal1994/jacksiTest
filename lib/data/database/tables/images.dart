import 'package:drift/drift.dart';
import 'package:jacksi_test/data/database/tables/product.dart';

@DataClassName('Image')
class Images extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  IntColumn get productId => integer().references(Products, #id)();
}
