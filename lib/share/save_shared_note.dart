import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../db/note_dao.dart';

class SaveSharedNote extends StatefulWidget {
  @override
  _SaveSharedNoteState createState() => _SaveSharedNoteState();

  String? sharedText = "";

  SaveSharedNote({Key? key, this.sharedText})
      : super(key: key);
}

class _SaveSharedNoteState extends State<SaveSharedNote> {
  TextEditingController controllerNoteTitle = TextEditingController();
  TextEditingController controllerNoteText = TextEditingController();

  @override
  void initState() {
    controllerNoteText.text = widget.sharedText!;
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {

    final Color? bottomOverlayColor =
        Theme.of(context).bottomNavigationBarTheme.backgroundColor;
    final Color? topOverlayColor =
        Theme.of(context).appBarTheme.backgroundColor;
    final Brightness iconBrightness =
        Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarColor: bottomOverlayColor,
        statusBarColor: topOverlayColor,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Save Shared Note'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkErrors().isEmpty) {
                    _saveNote().then((_) => {SystemNavigator.pop()});
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
                style: const TextStyle(fontSize: 18),
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
