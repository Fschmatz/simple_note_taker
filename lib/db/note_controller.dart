

import '../class/note.dart';
import 'note_dao.dart';

void saveNote(Note note) async {
  final dbNote = NoteDao.instance;
  Map<String, dynamic> row = {
    NoteDao.columnTitle: note.title,
    NoteDao.columnText: note.text,
    NoteDao.columnArchived: 0,
  };
  await dbNote.insert(row);
}

void updateNote(Note note) async {
  final dbNote = NoteDao.instance;
  Map<String, dynamic> row = {
    NoteDao.columnIdNote: note.idNote,
    NoteDao.columnTitle: note.title,
    NoteDao.columnText: note.text,
    NoteDao.columnArchived: note.archived
  };
  await dbNote.update(row);
}

void deleteNote(int idNote) async {
  final notes = NoteDao.instance;
  await notes.delete(idNote);
}

void archiveNote(int idNote,int archiveValue) async {
  final notes = NoteDao.instance;
  Map<String, dynamic> row = {
    NoteDao.columnIdNote: idNote,
    NoteDao.columnArchived: archiveValue,//widget.note.archived == 0 ? 1 : 0,
  };
  await notes.update(row);
}