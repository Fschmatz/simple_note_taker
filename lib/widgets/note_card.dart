import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../class/note.dart';
import '../pages/edit_note.dart';
import '../service/note_service.dart';

class NoteCard extends StatefulWidget {
  @override
  _NoteCardState createState() => _NoteCardState();

  Note note;
  int index;
  Function() refreshHome;

  NoteCard({Key? key, required this.note, required this.index, required this.refreshHome}) : super(key: key);
}

class _NoteCardState extends State<NoteCard> {
  NoteService noteService = NoteService();

  Future<void> _deleteNote() async {
    noteService.delete(widget.note.id!);
  }

  Future<void> _archiveNote() async {
    noteService.archiveNote(widget.note.id!);
  }

  Future<void> _unarchiveNote() async {
    noteService.unarchiveNote(widget.note.id!);
  }

  void openEditPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => EditNote(
            note: widget.note,
            refreshHome: widget.refreshHome,
          ),
        ));
  }

  void openBottomMenu() {
    bool notArchived = widget.note.archived == 0;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      "Created at: ",
                    ),
                    trailing: Text(widget.note.formattedCreationDate, style: const TextStyle(fontSize: 14)),
                  ),
                  const Divider(),
                  ListTile(
                    leading: notArchived ? const Icon(Icons.archive_outlined) : const Icon(Icons.unarchive_outlined),
                    title: notArchived
                        ? const Text(
                            "Archive",
                          )
                        : const Text(
                            "Unarchive",
                          ),
                    onTap: () {
                      if (notArchived) {
                        _archiveNote();
                      } else {
                        _unarchiveNote();
                      }

                      widget.refreshHome();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.share_outlined),
                    title: const Text(
                      "Share",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Share.share(widget.note.title! + "\n" + widget.note.text!);
                    },
                  ),
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
                _deleteNote();
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
    final theme = Theme.of(context);

    return Card.outlined(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: openEditPage,
        onLongPress: openBottomMenu,
        title: Text(
          widget.note.title!,
        ),
        subtitle: widget.note.text!.isNotEmpty
            ? Text(widget.note.text!, maxLines: 5, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: theme.hintColor))
            : null,
      ),
    );
  }
}
