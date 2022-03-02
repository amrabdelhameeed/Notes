import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_final/data/models/colorModel.dart';
import 'package:todo_final/data/models/note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  String textkey = "text";
  String colorkey = "color";
  String themeKey = "themetest";
  late List<String> indexsOfColors;
  late List<String> titles;
  late SharedPreferences _prefs;
  List<Note> notes = [];
  List<ColorModel> colors = [
    ColorModel(color: Color(0xff34856c)),
    ColorModel(color: Color(0xff456ae6)),
    ColorModel(color: Colors.pink),
    ColorModel(color: Color(0xffa234c9)),
    ColorModel(color: Color(0xffc93481)),
    ColorModel(color: Color(0xff36878f)),
    ColorModel(color: Color(0xffd4b04c)),
    ColorModel(color: Colors.blue),
    ColorModel(color: Colors.pink),
    ColorModel(color: Colors.deepOrange),
    ColorModel(color: Colors.cyan),
  ];

  void textchanged() {
    emit(Textchanged());
  }

  Color getRandomColor() {
    return colors[Random().nextInt(colors.length)].color;
  }

  void makeAllSelectedFalse() {
    colors.forEach((color) {
      color.isSelected = false;
    });
    emit(MakeAllSelectedFalseState());
  }

  void updateColorSelection(int indexOfColor) {
    makeAllSelectedFalse();
    print(indexOfColor.toString() +
        " da indexof color , note bt3 updateColorSelection");
    colors[indexOfColor].isSelected = true;
    emit(ColorChanged());
  }

  TextEditingController textcontroller = TextEditingController();

  int colorChooser() {
    int? i;
    colors.asMap().forEach((index, color) {
      if (color.isSelected == true) {
        i = index;
        return;
      }
    });
    if (i == null) {
      return 0;
    }
    return i!;
  }

  void removeNote(int index) {
    notes.removeAt(index);
    titles.removeAt(index);
    indexsOfColors.removeAt(index);
    savetoSp();
    reInsertAllNotes();
    emit(NoteDeleted());
  }

  void addNote(String title, int indexOfColor, int indexOfNote) {
    if (indexOfNote == -1) {
      // -1 is the default value for adding new task
      titles.add(title);
      indexsOfColors.add(indexOfColor.toString());
    } else {
      // edit existing task
      titles.removeAt(indexOfNote);
      indexsOfColors.removeAt(indexOfNote);
      titles.insert(indexOfNote, title);
      indexsOfColors.insert(indexOfNote, indexOfColor.toString());
    }
    savetoSp();
    reInsertAllNotes();
    print(titles);
    emit(NoteAdded());
  }

  void editNoteStateCaller() {
    emit(EditNoteState());
  }

  // data base (shared pref.)//

  callGetInstanceSharedPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool? isDark;

  savetoSp() async {
    await callGetInstanceSharedPref();
    _prefs.setStringList(textkey, titles);
    _prefs.setStringList(colorkey, indexsOfColors);
    emit(SavetoPrefState());
  }

  getFromSp() async {
    await callGetInstanceSharedPref();
    titles = _prefs.getStringList(textkey)!;
    indexsOfColors = _prefs.getStringList(colorkey)!;
    isDark = _prefs.getBool(themeKey) ?? true;
    emit(LoadFromPrefState());
  }

  reInsertAllNotes() async {
    await callGetInstanceSharedPref();
    notes.clear();
    indexsOfColors.asMap().forEach((i, colorindex) {
      notes.add(Note(
          color: colors[int.parse(colorindex)].color,
          name: titles[i],
          indexOfColor: int.parse(colorindex),
          indexOfNote: i));
    });
    emit(OpenAppState());
  }

  initializingSharedPrefrenceStuff() {
    getFromSp();
    reInsertAllNotes();
    emit(OpenAppState());
    indexsOfColors = [];
    titles = [];
    isDark = false;
  }

  noteAdded() {
    emit(NoteAdded());
  }

  saveToPrefTheme() async {
    await callGetInstanceSharedPref();
    _prefs.setBool(themeKey, isDark!);
    emit(SavetoPrefState());
  }

  toggleTheme() {
    isDark = !isDark!;
    saveToPrefTheme();
  }
}
