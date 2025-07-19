import '../class/note.dart';

class AppState {
  List<Note> notes = [];
  List<Note> archiveNotes = [];

  AppState({required this.notes, required this.archiveNotes});

  static AppState initialState() => AppState(
        notes: [],
        archiveNotes: [],
      );

  AppState copyWith({
    List<Note>? notes,
    List<Note>? archiveNotes,
  }) {
    return AppState(
      notes: notes ?? this.notes,
      archiveNotes: archiveNotes ?? this.archiveNotes,
    );
  }
}
