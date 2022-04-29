import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../class/note.dart';
import '../db/note_dao.dart';
import '../pages/edit_note.dart';

class PlaylistTile extends StatefulWidget {
  @override
  _PlaylistTileState createState() => _PlaylistTileState();

  Note playlist;
  Function() refreshHome;

  PlaylistTile({Key? key, required this.playlist, required this.refreshHome})
      : super(key: key);
}

class _PlaylistTileState extends State<PlaylistTile> {


  void _delete() async {
    final playlists = NoteDao.instance;
    final deleted = await playlists.delete(widget.playlist.idNote);
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
                    leading: const Icon(Icons.share_outlined),
                    title: const Text(
                      "Share",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                     // Share.share(widget.playlist.link);
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
                              note: widget.playlist,
                              refreshHome: widget.refreshHome,
                            ),
                          ));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete_outline_outlined),
                    title: const Text(
                      "Delete playlist",
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
    return ListTile(
      //onTap: _launchLink,
      onLongPress: openBottomMenu,
      title: Text('oi'),
    );
  }
}
