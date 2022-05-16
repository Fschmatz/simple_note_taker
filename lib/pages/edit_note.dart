import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../class/note.dart';
import '../db/note_controller.dart';

class EditNote extends StatefulWidget {
  @override
  _EditNoteState createState() => _EditNoteState();

  Function() refreshHome;
  Note note;

  EditNote({Key? key, required this.refreshHome, required this.note})
      : super(key: key);
}

class _EditNoteState extends State<EditNote> {
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();

  @override
  void initState() {
    controllerNoteTitle.text = widget.note.title;
    controllerNoteText.text = widget.note.text;
    super.initState();
  }

  Future<void> _updateNote() async {
    updateNote(Note(
        idNote: widget.note.idNote,
        title: controllerNoteTitle.text,
        text: controllerNoteText.text,
        archived: widget.note.archived));
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
            title: const Text('Edit Note'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkErrors().isEmpty) {
                    _updateNote().then((v) =>
                        {widget.refreshHome(), Navigator.of(context).pop()});
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
                maxLines: 2,
                maxLength: 300,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
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
                maxLines: 15,
                maxLength: 1500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
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
