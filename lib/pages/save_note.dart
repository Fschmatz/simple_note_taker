import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_note_taker/db/note_controller.dart';
import '../class/note.dart';

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
    saveNote(Note(
        idNote: 0,
        title: controllerNoteTitle.text,
        text: controllerNoteText.text,
        archived: 0));
  }

  String checkErrors() {
    String errors = "";
    if (controllerNoteTitle.text.isEmpty) {
      errors += "Insert title\n";
    }
    return errors;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                minLines: 1,
                maxLines: 2,
                maxLength: 300,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                controller: controllerNoteTitle,
                decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 18),
                    counterText: "",
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                minLines: 1,
                maxLines: null,
                maxLength: 2000,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                controller: controllerNoteText,
                decoration: const InputDecoration(
                    counterText: "",
                    fillColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hintText: "Note",
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ])),
    );
  }
}
