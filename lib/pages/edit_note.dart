import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool readOnlyState = true;

  @override
  void initState() {
    controllerNoteTitle.text = widget.note.title;
    controllerNoteText.text = widget.note.text + "\n\n\n\n\n\n\n\n\n\n";
    super.initState();
  }

  Future<void> _updateNote() async {
    updateNote(Note(
        idNote: widget.note.idNote,
        title: controllerNoteTitle.text,
        text: controllerNoteText.text.trim(),
        archived: widget.note.archived));
  }

  _launchUrl(String link) {
    launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    );
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!readOnlyState) {
          if (checkErrors().isEmpty) {
            _updateNote().then(
                (v) => {widget.refreshHome(), Navigator.of(context).pop()});
          } else {
            showAlertDialogErrors(context);
          }
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              !readOnlyState
                  ? IconButton(
                      icon: const Icon(Icons.save_outlined),
                      tooltip: 'Save',
                      onPressed: () {
                        if (!readOnlyState) {
                          if (checkErrors().isEmpty) {
                            _updateNote().then((v) => {
                                  widget.refreshHome(),
                                  Navigator.of(context).pop()
                                });
                          } else {
                            showAlertDialogErrors(context);
                          }
                        }
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                readOnly: readOnlyState,
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
                child: DetectableTextField(
                  readOnly: readOnlyState,
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
                    readOnlyState ? _launchUrl(text) : null;
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
                )),
            const SizedBox(
              height: 50,
            ),
          ]),
          floatingActionButton: readOnlyState
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      readOnlyState = !readOnlyState;
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
