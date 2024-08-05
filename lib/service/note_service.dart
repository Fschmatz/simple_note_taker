import '../class/note.dart';
import '../db/note_dao.dart';

class NoteService {
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
  }

  void update(Note note) async {
    Map<String, dynamic> row = {
      NoteDao.columnId: note.id,
      NoteDao.columnTitle: note.title,
      NoteDao.columnText: note.text
      /*,
      NoteDao.columnArchived: note.archived,
      NoteDao.columnCreationDate: note.creationDate*/
    };

    await dbNote.update(row);
  }

  void delete(int idNote) async {
    await dbNote.delete(idNote);
  }

  void unarchiveNote(int id) async {
    Map<String, dynamic> row = {
      NoteDao.columnId: id,
      NoteDao.columnArchived: 0,
    };

    await dbNote.update(row);
  }

  void archiveNote(int id) async {
    Map<String, dynamic> row = {
      NoteDao.columnId: id,
      NoteDao.columnArchived: 1,
    };

    await dbNote.update(row);
  }

  Future<List<Map<String, dynamic>>> loadAllNotes() {
    return dbNote.queryAllRows();
  }

  Future<void> deleteAllNotes() async {
    await dbNote.deleteAll();
  }

  Future<void> insertNotesFromRestoreBackup(List<dynamic> jsonData) async {
    for (dynamic item in jsonData) {
      await _insertMovieFromBackup(Note.fromMap(item));
    }
  }

  Future<void> _insertMovieFromBackup(Note note) async {
    Map<String, dynamic> row = {
      NoteDao.columnTitle: note.title,
      NoteDao.columnText: note.text,
      NoteDao.columnArchived: note.archived,
      NoteDao.columnCreationDate: note.creationDate
    };

    await dbNote.insert(row);
  }
}
