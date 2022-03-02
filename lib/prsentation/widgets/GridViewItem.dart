import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_final/bloc/cubit/note_cubit.dart';
import 'package:todo_final/constants/strings.dart';
import 'package:todo_final/data/models/note.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({Key? key, required this.note}) : super(key: key);
  final Note note;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = BlocProvider.of<NoteCubit>(context);
        return InkWell(
          onTap: () {
            bloc.editNoteStateCaller();
            Navigator.pushNamed(context, EditScreenPage, arguments: note);
          },
          child: Container(
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: note.color,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              note.name,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        );
      },
    );
  }
}
