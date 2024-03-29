import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:share/share.dart';
import 'package:simple_note_taker/db/note_controller.dart';
import '../class/note.dart';
import '../pages/edit_note.dart';

class NoteTile extends StatefulWidget {
  @override
  _NoteTileState createState() => _NoteTileState();

  Note note;
  int index;
  Function() refreshHome;

  NoteTile(
      {Key? key,
      required this.note,
      required this.index,
      required this.refreshHome})
      : super(key: key);
}

class _NoteTileState extends State<NoteTile> {

  Future<void> _deleteNote() async {
    deleteNote(widget.note.idNote);
  }

  Future<void> _archiveNote() async {
    archiveNote(widget.note.idNote, widget.note.archived == 0 ? 1 : 0);
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
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  /*ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text(
                      "Edit",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      openEditPage();
                    },
                  ),
                  const Divider(),*/
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
    return Padding(
      padding:  const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline
          ),
        ),
        onTap: openEditPage,
        onLongPress: openBottomMenu,
        contentPadding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
        title: Text(
          widget.note.title,
        ),
        subtitle: widget.note.text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(widget.note.text,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .textTheme
                            .headline6!
                            .color!
                            .withOpacity(0.7))))
            : null,
      ),
    );
  }
}
