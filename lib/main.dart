import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_final/app_router.dart';
import 'package:todo_final/bloc/cubit/obsever.dart';
import 'package:todo_final/constants/strings.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: homePage,
      onGenerateRoute: appRouter.generateRoutes,
    );
  }
}
