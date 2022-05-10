import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/note_dao.dart';

class DialogPrintNotes extends StatefulWidget {
  DialogPrintNotes({Key? key}) : super(key: key);

  @override
  _DialogPrintNotesState createState() => _DialogPrintNotesState();
}

class _DialogPrintNotesState extends State<DialogPrintNotes> {
  List<Map<String, dynamic>> playlists = [];
  final dbNotes = NoteDao.instance;
  bool loading = true;
  String formattedList = '';

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  void getNotes() async {
    List<Map<String, dynamic>> _listNotes =
        await dbNotes.queryAllRowsDescArchive(0);
    List<Map<String, dynamic>> _listArchive =
        await dbNotes.queryAllRowsDescArchive(1);

    formattedList += '\nNOTES - ' + _listNotes.length.toString() + ' \n';
    for (int i = 0; i < _listNotes.length; i++) {
      if (_listNotes[i]['text'].toString().isNotEmpty) {
        formattedList += "\n• " + _listNotes[i]['title'] + "\n";
        formattedList += _listNotes[i]['text'] + "\n";
      } else {
        formattedList += "\n• " + _listNotes[i]['title'] + "\n";
      }
    }

    formattedList += '\n\nARCHIVE - ' + _listArchive.length.toString() + ' \n';
    for (int i = 0; i < _listArchive.length; i++) {
      if (_listArchive[i]['text'].toString().isNotEmpty) {
        formattedList += "\n• " + _listArchive[i]['title'] + "\n";
        formattedList += _listArchive[i]['text'] + "\n";
      } else {
        formattedList += "\n• " + _listArchive[i]['title'] + "\n";
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Notes'),
        actions: [
          TextButton(
            child: const Text(
              "Copy",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: formattedList));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        children: [
          loading
              ? const SizedBox.shrink()
              : SelectableText(
                  formattedList,
                  style: const TextStyle(fontSize: 16),
                ),
        ],
      ),
    );
  }
}
