import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../class/note.dart';
import '../service/note_service.dart';

class NewNote extends StatefulWidget {
  @override
  State<NewNote> createState() => _NewNoteState();

  const NewNote({Key? key}) : super(key: key);
}

class _NewNoteState extends State<NewNote> {
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();

  Future<void> _saveNote() async {
    NoteService().insert(Note(title: controllerNoteTitle.text, text: controllerNoteText.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Save Note'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: () {
                if (controllerNoteTitle.text.isNotEmpty) {
                  _saveNote().then((_) => {
                        Navigator.of(context).pop(),
                      });
                } else {
                  Fluttertoast.showToast(msg: "Insert title");
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
              style: const TextStyle(fontSize: 18),
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerNoteTitle,
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 18, letterSpacing: 0.5),
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
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
              autofocus: true,
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
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
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
        ]));
  }
}
