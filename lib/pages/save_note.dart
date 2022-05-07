import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/note_dao.dart';

class SaveNote extends StatefulWidget {
  @override
  _SaveNoteState createState() => _SaveNoteState();

  Function()? refreshHome;

  SaveNote({Key? key, required this.refreshHome}) : super(key: key);
}

class _SaveNoteState extends State<SaveNote> {
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();

  Future<void> _saveNote() async {
    final dbPlaylist = NoteDao.instance;

    Map<String, dynamic> row = {
      NoteDao.columnTitle: controllerNoteTitle.text,
      NoteDao.columnText: controllerNoteText.text,
      NoteDao.columnArchived: 0,
    };
    final id = await dbPlaylist.insert(row);
  }

  String checkErrors() {
    String erros = "";
    if (controllerNoteTitle.text.isEmpty) {
      erros += "Insert title\n";
    }
    return erros;
  }

  showAlertDialogErrors(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Error",
          ),
          content: Text(
            checkErrors(),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Ok",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _loseFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _loseFocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Save Note'),
            actions: [

              IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkErrors().isEmpty) {
                    _saveNote().then((v) => {
                          widget.refreshHome!(),
                          Navigator.of(context).pop(),
                        });
                  } else {
                    showAlertDialogErrors(context);
                  }
                },
              ),
            ],
          ),
          body: ListView(children: [
            ListTile(
              title: Text("Title",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                maxLength: 300,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: controllerNoteTitle,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.notes_outlined),
                  helperText: "* Required",
                  counterText: "",
                ),
              ),
            ),
            ListTile(
              title: Text("Text",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                minLines: 1,
                maxLines: 6,
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: controllerNoteText,
                decoration: const InputDecoration(
                  counterText: "",
                  prefixIcon: Icon(
                    Icons.notes_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ])),
    );
  }
}
