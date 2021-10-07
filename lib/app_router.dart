import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_final/bloc/cubit/note_cubit.dart';
import 'package:todo_final/constants/strings.dart';
import 'package:todo_final/data/models/note.dart';
import 'package:todo_final/prsentation/pages/edit_note_page.dart';
import 'package:todo_final/prsentation/pages/homeLayout.dart';

class AppRouter {
  NoteCubit? noteCubit;
  AppRouter() {
    noteCubit = NoteCubit();
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<NoteCubit>.value(
            value: noteCubit!..initializingSharedPrefrenceStuff(),
            child: HomeLayout(),
          );
        });
      case EditScreenPage:
        Note note = settings.arguments as Note;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<NoteCubit>.value(
            value: noteCubit!,
            child: EditNotePage(
              note: note,
            ),
          );
        });
    }
  }
}
