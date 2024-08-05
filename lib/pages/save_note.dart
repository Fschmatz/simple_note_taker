import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../class/note.dart';
import '../service/note_service.dart';

class SaveNote extends StatefulWidget {
  @override
  _SaveNoteState createState() => _SaveNoteState();

  Function()? refreshHome;

  SaveNote({Key? key, required this.refreshHome}) : super(key: key);
}

class _SaveNoteState extends State<SaveNote> {
  NoteService noteService = NoteService();
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();

  Future<void> _saveNote() async {
    Note noteToInsert = Note();

    noteToInsert.title = controllerNoteTitle.text;
    noteToInsert.text = controllerNoteText.text.trim();

    noteService.insert(noteToInsert);
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
                  _saveNote().then((v) => {
                        widget.refreshHome!(),
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
            child: DetectableTextField(
              autofocus: true,
              minLines: 1,
              maxLines: null,
              maxLength: 2000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerNoteText,
              detectionRegExp: RegExp(
                "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                multiLine: true,
              ),
              basicStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              decoratedStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
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
