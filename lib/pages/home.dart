import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/archive.dart';
import 'package:simple_note_taker/redux/actions.dart';
import 'package:simple_note_taker/redux/build_context_extension.dart';
import 'package:simple_note_taker/util/app_details.dart';

import '../class/note.dart';
import '../main.dart';
import '../redux/selectors.dart';
import '../widgets/note_card.dart';
import 'configs/settings.dart';
import 'new_note.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();

  const Home({Key? key}) : super(key: key);
}

class _HomeState extends State<Home> {
  List<Note> notesList = [];

  @override
  Widget build(BuildContext context) {
    notesList = selectNotes(context.state);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppDetails.appNameHomePage),
        actions: [
          IconButton(
              icon: const Icon(Icons.archive_outlined),
              onPressed: () async {
                await store.dispatch(LoadArchiveNotesAction());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Archive(),
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
                      builder: (BuildContext context) => const Settings(),
                    ));
              }),
        ],
      ),
      body: ListView(
        children: [
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: notesList.length,
            itemBuilder: (context, int index) {
              Note note = notesList[index];

              return NoteCard(key: UniqueKey(), note: note);
            },
          ),
          const SizedBox(
            height: 75,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const NewNote(),
              ));
        },
        child: const Icon(
          Icons.add_outlined,
        ),
      ),
    );
  }
}
