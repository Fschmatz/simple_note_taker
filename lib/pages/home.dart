import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/archived_notes_list.dart';
import 'package:simple_note_taker/pages/notes_list.dart';
import 'package:simple_note_taker/util/app_details.dart';
import 'configs/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTabIndex = 0;

  /* List<Widget> _tabs = [
    NotesList(
      key: UniqueKey(),
      archivedValue: 0,
    ),
    NotesList(
      key: UniqueKey(),
      archivedValue: 1,
    ),
  ];*/

  void refresh() {
    setState(() {
      /* _tabs = [
        NotesList(
          key: UniqueKey(),
          archivedValue: 0,
        ),
        NotesList(
          key: UniqueKey(),
          archivedValue: 1,
        ),
      ];*/
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppDetails.appNameHomePage),
        actions: [
          IconButton(
              icon: const Icon(Icons.archive_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ArchivedNotesList(),
                    ));
              }),
          IconButton(
              icon: const Icon(
                Icons.settings_outlined,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Settings(
                        refreshHome: refresh,
                      ),
                    ));
              }),
        ],
      ),
      body: NotesList(),
    );
  }
}
