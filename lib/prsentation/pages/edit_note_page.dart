import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_final/bloc/cubit/note_cubit.dart';
import 'package:todo_final/data/models/note.dart';

// ignore: must_be_immutable
class EditNotePage extends StatelessWidget {
  EditNotePage({Key? key, required this.note}) : super(key: key);
  final Note note;
  String title = "";
  bool isRTL = false;
  Color? color;
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NoteCubit>(context);

    Widget _constSizedBox() {
      return SizedBox(
        height: 10,
      );
    }

    Widget _textFormFoeldWidget() {
      return Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: AutoDirection(
          onDirectionChange: (isRTL) {
            this.isRTL = isRTL;
            //bloc.textchanged();
          },
          text: title.length > 1 ? title.substring(title.length - 2) : title,
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 25, height: 1.3),
            maxLines: 15,
            minLines: 12,
            onChanged: (v) {
              title = v;
              bloc.textchanged();
            },
            initialValue: note.name,
          ),
        ),
      );
    }

    Widget _circleAvataeColorItem(int index) {
      return InkWell(
        onTap: () {
          bloc.updateColorSelection(
            index,
          );
          color = bloc.colors[bloc.colorChooser()].color;
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.white,
                  width: bloc.colors[index].isSelected ? 5 : 0)),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: bloc.colors[index].color,
          ),
        ),
      );
    }

    Widget _colorsListView() {
      return Container(
        height: 60,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: bloc.colors.length,
          itemBuilder: (context, index) {
            return _circleAvataeColorItem(index);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 5,
            );
          },
        ),
      );
    }

    void _addButton() {
      if (title.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "حط داتا يا نجم",
          ),
          duration: Duration(seconds: 1),
        ));
      }
      if (title.isNotEmpty) {
        bloc.addNote(title, bloc.colorChooser(), note.indexOfNote);
      }
    }

/*  */
    return BlocConsumer<NoteCubit, NoteState>(
      listenWhen: (prev, cur) {
        return prev != cur;
      },
      listener: (context, state) {
        var bloc = BlocProvider.of<NoteCubit>(context);
        if (state is EditNoteState) {
          bloc.updateColorSelection(note.indexOfColor);
        }
        if (state is NoteAdded) {
          bloc.makeAllSelectedFalse();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<NoteCubit>(context);
        if (state is EditNoteState) {
          color = bloc.colors[note.indexOfColor].color;
          bloc.updateColorSelection(note.indexOfColor);
          title = note.name;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: color,
            actions: [
              Container(
                height: 5,
                width: 80,
                child: InkWell(
                  onTap: () {
                    _addButton();
                  },
                  child: Center(child: Text("Save")),
                ),
              )
            ],
          ),
          backgroundColor: color,
          body: Column(
            children: [
              _textFormFoeldWidget(),
              _colorsListView(),
              _constSizedBox(),
            ],
          ),
        );
      },
    );
  }
}
