import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksi_test/ui/add_product/blocs/add_product/add_product_bloc.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import 'app.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl.allReady(); // wait for required async initialization

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CategoryBloc>(
        create: (context) => sl<CategoryBloc>(),
      ),

      BlocProvider<AddProductBloc>(
        create: (context) => sl<AddProductBloc>(),
      ),
    ],
    child: App(),
  ));
}


