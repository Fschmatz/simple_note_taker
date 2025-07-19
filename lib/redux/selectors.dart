import '../class/note.dart';
import 'app_state.dart';

List<Note> selectNotes(AppState state) => state.notes;

List<Note> selectArchiveNotes(AppState state) => state.archiveNotes;
