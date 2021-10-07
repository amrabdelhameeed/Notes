import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_final/bloc/cubit/note_cubit.dart';
import 'package:todo_final/prsentation/widgets/GridViewItem.dart';

class GridviewWidget extends StatelessWidget {
  const GridviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NoteCubit>(context);

    void _showDialog(int index) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                Container(
                    height: 70,
                    child: Center(
                        child: Text(
                      "Are u sure to delete ?",
                      style: TextStyle(fontSize: 20),
                    ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("back")),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bloc.removeNote(index);
                          Navigator.pop(context);
                        },
                        child: Text("delete")),
                  ],
                )
              ],
            );
          });
    }

    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: bloc.notes.length,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () {
                _showDialog(index);
              },
              child: GridViewItem(
                note: bloc.notes[index],
              ),
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.count(
              2,
              bloc.notes[index].name.length > 35
                  ? 3
                  : (bloc.notes[index].name.length > 25 ? 2 : 1)),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
      },
    );
  }
}
