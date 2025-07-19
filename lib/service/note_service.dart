import 'package:simple_note_taker/service/store_service.dart';

import '../class/note.dart';
import '../db/note_dao.dart';

class NoteService extends StoreService {
  final dbNote = NoteDao.instance;

  Future<List<Note>> queryAllRowsDescByArchivedValue(int archivedValue) async {
    var resp = await dbNote.queryAllRowsDescByArchivedValue(archivedValue);

    return resp.isNotEmpty ? resp.map((map) => Note.fromMap(map)).toList() : [];
  }

  void insert(Note note) async {
    Map<String, dynamic> row = {
      NoteDao.columnTitle: note.title,
      NoteDao.columnText: note.text,
      NoteDao.columnArchived: 0,
      NoteDao.columnCreationDate: DateTime.now().toString()
    };

    await dbNote.insert(row);

    await loadNotes(0);
  }

  void update(Note note) async {
    Map<String, dynamic> row = {NoteDao.columnId: note.id, NoteDao.columnTitle: note.title, NoteDao.columnText: note.text};

    await dbNote.update(row);

    await loadNotes(note.archived!);
  }

  void delete(Note note) async {
    await dbNote.delete(note.id!);
    await loadNotes(note.archived!);
  }

  void unarchiveNote(int id) async {
    Map<String, dynamic> row = {
      NoteDao.columnId: id,
      NoteDao.columnArchived: 0,
    };

    await dbNote.update(row);
    await loadAllNotes();
  }

  void archiveNote(int id) async {
    Map<String, dynamic> row = {
      NoteDao.columnId: id,
      NoteDao.columnArchived: 1,
    };

    await dbNote.update(row);
    await loadAllNotes();
  }

  Future<List<Map<String, dynamic>>> loadAllNotesForBackup() {
    return dbNote.queryAllRows();
  }

  Future<void> deleteAllNotes() async {
    await dbNote.deleteAll();
  }

  Future<void> insertNotesFromRestoreBackup(List<dynamic> jsonData) async {
    List<Map<String, dynamic>> listToInsert = jsonData.map((item) {
      return Note.fromMap(item).toMap();
    }).toList();

    await dbNote.insertBatchForBackup(listToInsert);
    await loadNotes(0);
  }
}
