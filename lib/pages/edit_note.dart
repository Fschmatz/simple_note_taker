import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../class/note.dart';
import '../service/note_service.dart';
import '../util/utils.dart';

class EditNote extends StatefulWidget {
  @override
  _EditNoteState createState() => _EditNoteState();

  Function() refreshHome;
  Note note;

  EditNote({Key? key, required this.refreshHome, required this.note}) : super(key: key);
}

class _EditNoteState extends State<EditNote> {
  NoteService noteService = NoteService();
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();
  bool readOnly = true;

  @override
  void initState() {
    super.initState();

    controllerNoteTitle.text = widget.note.title!;
    controllerNoteText.text = widget.note.text! + "\n\n\n\n\n\n\n\n\n\n";
  }

  Future<void> _updateNote() async {
    Note noteToUpdate = widget.note;

    noteToUpdate.title = controllerNoteTitle.text;
    noteToUpdate.text = controllerNoteText.text.trim();

    noteService.update(noteToUpdate);
  }

  _launchLink(String link) {
    Utils().launchBrowser(link);
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
            _updateNote().then((v) => {widget.refreshHome()});
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
                            _updateNote().then((v) => {widget.refreshHome(), Navigator.of(context).pop()});
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
                child: DetectableTextField(
                  readOnly: readOnly,
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
                  onDetectionTyped: (text) {
                    readOnly ? _launchLink(text) : null;
                  },
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
