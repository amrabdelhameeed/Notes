part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class ColorChanged extends NoteState {}

class NoteAdded extends NoteState {}

class EditNoteState extends NoteState {}

class CloseEditingPageState extends NoteState {}

class ColorChooser extends NoteState {}

class MakeAllSelectedFalseState extends NoteState {}

class NoteDeleted extends NoteState {}

class SavetoPrefState extends NoteState {}

class LoadFromPrefState extends NoteState {}

class DeleteFromPrefState extends NoteState {}

class OpenAppState extends NoteState {}

class Textchanged extends NoteState {}
