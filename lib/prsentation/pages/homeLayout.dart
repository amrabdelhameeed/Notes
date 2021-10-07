import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_final/bloc/cubit/note_cubit.dart';
import 'package:todo_final/constants/strings.dart';
import 'package:todo_final/data/models/note.dart';
import 'package:todo_final/prsentation/widgets/GridviewWidget.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NoteCubit>(context);
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: bloc.isDark! ? Colors.white : Colors.black,
          appBar: AppBar(
            title: Text(
              "Notes",
              style: TextStyle(
                  fontSize: 25,
                  color: !bloc.isDark! ? Colors.white : Colors.black),
            ),
            elevation: 0,
            backgroundColor: bloc.isDark! ? Colors.white : Colors.black,
            actions: [
              IconButton(
                onPressed: () {
                  bloc.toggleTheme();
                },
                icon: Icon(bloc.isDark! ? Icons.dark_mode : Icons.light_mode),
                color: !bloc.isDark! ? Colors.white : Colors.black,
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: bloc.isDark! ? Colors.black : Colors.white,
            child: Icon(
              Icons.add,
              color: !bloc.isDark! ? Colors.black : Colors.white,
            ),
            onPressed: () {
              bloc.editNoteStateCaller();
              Navigator.pushNamed(context, EditScreenPage,
                  arguments: Note(
                      color: bloc.colors[bloc.colorChooser()].color,
                      indexOfNote: -1,
                      indexOfColor: Random().nextInt(bloc.colors.length)));
            },
          ),
          body: GridviewWidget(),
        );
      },
    );
  }
}
