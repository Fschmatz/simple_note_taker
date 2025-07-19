import '../class/note.dart';
import '../service/note_service.dart';
import 'app_action.dart';
import 'app_state.dart';

class LoadNotesAction extends AppAction {
  @override
  Future<AppState> reduce() async {
    List<Note> notes = await NoteService().queryAllRowsDescByArchivedValue(0);

    return state.copyWith(notes: notes);
  }
}

class LoadArchiveNotesAction extends AppAction {
  @override
  Future<AppState> reduce() async {
    List<Note> archiveNotes = await NoteService().queryAllRowsDescByArchivedValue(1);

    return state.copyWith(archiveNotes: archiveNotes);
  }
}

class LoadAllNotesAction extends AppAction {
  @override
  Future<AppState> reduce() async {
    List<Note> notes = await NoteService().queryAllRowsDescByArchivedValue(0);
    List<Note> archiveNotes = await NoteService().queryAllRowsDescByArchivedValue(1);

    return state.copyWith(notes: notes, archiveNotes: archiveNotes);
  }
}
