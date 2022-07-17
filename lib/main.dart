import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:road_ster/application/date_picking_car/date_picking_cubit.dart';
import 'package:road_ster/presentation/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/core/colors.dart';

late SharedPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  preferences = await SharedPreferences.getInstance();
  await preferences.remove("carByDate");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRoute = AppRoutes();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 856.7272727272727),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider(
            create: (context) => DatePickingCubit
            (),
            child: GetMaterialApp(
              supportedLocales: const [
                Locale('en', 'US'), // English
              ],
              builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: child!),
              debugShowCheckedModeBanner: false,
              title: 'RoadSter',
              theme: ThemeData(
                canvasColor: Colors.transparent,
                scaffoldBackgroundColor: backgroundColor,
                primarySwatch: Colors.cyan,
              ),
              onGenerateRoute: _appRoute.onGenerateRoutes,
            ),
          );
        });
  }
}
