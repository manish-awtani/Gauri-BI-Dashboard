import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_cubit/dayp_count/cubit/dayp_count_cubit.dart';
import 'package:flutter_application_1/bloc_cubit/dayp_event/cubit/dayp_cubit.dart';
import 'package:flutter_application_1/charts/InfiniteScrolling.dart';
import 'package:flutter_application_1/charts/skeleton_example.dart';
import 'package:flutter_application_1/routes/routes.dart';
import 'package:flutter_application_1/screens/examples/exampleSfDataGrid.dart';
import 'package:flutter_application_1/screens/examples/homeScreen.dart';
import 'package:flutter_application_1/services/dependecy_injection.dart';
import 'package:flutter_application_1/services/sembast_service.dart';
import 'package:flutter_application_1/utils/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  AppRoutes appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DaypCubit(
          // getIt<SembastService>()
          )),
        BlocProvider(create: (context) => DaypCountCubit(
          // getIt<SembastService>()
          )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        darkTheme: SrkayAppTheme.darkTheme,
        theme: SrkayAppTheme.lightTheme,
        onGenerateRoute: appRoutes.onGenerateRoute,
      ),
    );
  }
}
