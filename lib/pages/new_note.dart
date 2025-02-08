import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../class/note.dart';
import '../service/note_service.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class NewNote extends StatefulWidget {
  final Function()? refreshHome;

  const NewNote({Key? key, required this.refreshHome}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  NoteService noteService = NoteService();
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();

  Future<void> _pickAndReadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;

      File file = File(filePath);
      String content = await file.readAsString();

      setState(() {
        controllerNoteText.text = content;
      });
    }
  }

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
              icon: const Icon(Icons.file_download_outlined),
              tooltip: 'Save',
              onPressed: () {
                _pickAndReadFile();
              },
            ),
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
