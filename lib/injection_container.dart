import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:jacksi_test/data/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'data/database/database.dart';
import 'dart:io';

final sl = GetIt.instance;

Future<void> init() async {
   sl.registerSingletonAsync<Repository>(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return Repository(Database(NativeDatabase.createInBackground(file)));
  });
}
