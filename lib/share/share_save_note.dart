import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app.dart';
import '../class/init_data.dart';
import '../db/note_dao.dart';

class ShareSaveNote extends StatefulWidget {
  @override
  _ShareSaveNoteState createState() => _ShareSaveNoteState();

  String? sharedText = "";
  bool outsideMemory;

  ShareSaveNote({Key? key, this.sharedText, required this.outsideMemory}) : super(key: key);
}

class _ShareSaveNoteState extends State<ShareSaveNote> {
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
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Save Shared Note'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save_outlined),
                  tooltip: 'Save',
                  onPressed: () {
                    if (checkErrors().isEmpty) {
                      if(widget.outsideMemory){
                        //save the last link who came from outside
                        InitData initData = InitData('', '');
                        initData.saveToPrefs(widget.sharedText!);
                      }
                      _saveNote().then((v) => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const App()),
                                ModalRoute.withName('/'))
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
                child:  DetectableTextField(
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
                  decoratedStyle : const TextStyle(
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
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ])),
      ),
    );
  }
}
