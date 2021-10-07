import 'package:flutter/material.dart';

class Note {
  String name;
  Color color;
  int indexOfNote;
  int indexOfColor;
  Note(
      {this.name = "",
      required this.color,
      this.indexOfNote = -1,
      this.indexOfColor = 0});

  Map<String, dynamic> toMap() {
    return {'name': name, 'indexofcolor': indexOfColor};
  }
}
