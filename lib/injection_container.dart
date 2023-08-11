import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:jacksi_test/data/repository.dart';
import 'package:jacksi_test/ui/add_product/blocs/add_product/add_product_bloc.dart';
import 'package:jacksi_test/ui/add_product/viewmodels/add_product_viewmodel.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'data/database/database.dart';
import 'dart:io';

final sl = GetIt.instance;

Future<void> init() async {

  // blocks
  sl.registerFactory<CategoryBloc>(() => CategoryBloc(sl()));
  sl.registerFactory<AddProductBloc>(() => AddProductBloc(sl()));

  // ViewModels
  sl.registerFactory<HomePageViewModel>(() => HomePageViewModel(sl()));
  sl.registerFactory<AddProductViewModel>(() => AddProductViewModel());

  // repositories
  sl.registerSingletonAsync<Repository>(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return Repository(Database(NativeDatabase.createInBackground(file)));
  });
}
