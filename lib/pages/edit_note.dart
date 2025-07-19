import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../class/note.dart';
import '../service/note_service.dart';

class EditNote extends StatefulWidget {
  @override
  State<EditNote> createState() => _EditNoteState();

  const EditNote({Key? key, required this.note}) : super(key: key);

  final Note note;
}

class _EditNoteState extends State<EditNote> {
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();
  bool readOnly = true;

  @override
  void initState() {
    super.initState();

    controllerNoteTitle.text = widget.note.title!;
    controllerNoteText.text = widget.note.text! + "\n\n\n\n\n\n\n\n";
  }

  Future<void> _updateNote() async {
    Note noteToUpdate = widget.note;
    noteToUpdate.title = controllerNoteTitle.text;
    noteToUpdate.text = controllerNoteText.text.trim();

    NoteService().update(noteToUpdate);
  }

  String _formatNoteToCopy() {
    return controllerNoteTitle.text + "\n\n" + controllerNoteText.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (!readOnly) {
          if (controllerNoteTitle.text.isNotEmpty) {
            _updateNote();
          } else {
            Fluttertoast.showToast(msg: "Insert title");
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              !readOnly
                  ? IconButton(
                      icon: const Icon(Icons.save_outlined),
                      tooltip: 'Save',
                      onPressed: () {
                        if (!readOnly) {
                          if (controllerNoteTitle.text.isNotEmpty) {
                            _updateNote().then((_) => Navigator.of(context).pop());
                          } else {
                            Fluttertoast.showToast(msg: "Insert title");
                          }
                        }
                      },
                    )
                  : const SizedBox.shrink(),
              IconButton(
                icon: const Icon(Icons.copy_outlined),
                tooltip: 'Save',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _formatNoteToCopy()));
                },
              )
            ],
          ),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                readOnly: readOnly,
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
                  readOnly: readOnly,
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
                )),
            const SizedBox(
              height: 50,
            ),
          ]),
          floatingActionButton: readOnly
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      readOnly = !readOnly;
                    });
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                  ),
                )
              : null),
    );
  }
}
