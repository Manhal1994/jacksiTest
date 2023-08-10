import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/data/repository.dart';
import 'package:jacksi_test/ui/add_product/blocs/add_product/add_product_bloc.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import 'package:jacksi_test/ui/home/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl.allReady(); // wait for required async initialization

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AddProductBloc>(
        create: (context) => AddProductBloc(di.sl<Repository>()),
      ),
      BlocProvider<CategoryBloc>(
        create: (context) => CategoryBloc(di.sl<Repository>()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage()


          );
        });
  }
}
