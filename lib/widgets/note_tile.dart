import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:share/share.dart';
import '../class/note.dart';
import '../db/note_dao.dart';
import '../pages/edit_note.dart';

class NoteTile extends StatefulWidget {
  @override
  _NoteTileState createState() => _NoteTileState();

  Note note;
  Function() refreshHome;

  NoteTile({Key? key, required this.note, required this.refreshHome})
      : super(key: key);
}

class _NoteTileState extends State<NoteTile> {
  void _delete() async {
    final notes = NoteDao.instance;
    final deleted = await notes.delete(widget.note.idNote);
  }

  Future<void> _archiveNote() async {
    final notes = NoteDao.instance;
    Map<String, dynamic> row = {
      NoteDao.columnIdNote: widget.note.idNote,
      NoteDao.columnArchived: widget.note.archived == 0 ? 1 : 0,
    };
    final update = await notes.update(row);
  }

  void openBottomMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: widget.note.archived == 0
                        ? const Icon(Icons.archive_outlined)
                        : const Icon(Icons.unarchive_outlined),
                    title: widget.note.archived == 0
                        ? const Text(
                            "Archive",
                          )
                        : const Text(
                            "Unarchive",
                          ),
                    onTap: () {
                      _archiveNote();
                      widget.refreshHome();
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.share_outlined),
                    title: const Text(
                      "Share",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Share.share(widget.note.title + "\n" + widget.note.text);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text(
                      "Edit",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => EditNote(
                              note: widget.note,
                              refreshHome: widget.refreshHome,
                            ),
                          ));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete_outline_outlined),
                    title: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showAlertDialogOkDelete(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  showAlertDialogOkDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm",
          ),
          content: const Text(
            "Delete ?",
          ),
          actions: [
            TextButton(
              child: const Text(
                "Yes",
              ),
              onPressed: () {
                _delete();
                widget.refreshHome();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          onTap: openBottomMenu,
          title: Text(
            widget.note.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: widget.note.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: LinkWell(widget.note.text,
                      linkStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.8),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textTheme
                              .headline6!
                              .color!
                              .withOpacity(0.7))),
                )
              : null,
        ),
      ],
    );
  }
}
