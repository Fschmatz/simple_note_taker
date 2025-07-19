import 'package:flutter/material.dart';
import 'package:simple_note_taker/redux/build_context_extension.dart';
import 'package:simple_note_taker/redux/selectors.dart';

import '../class/note.dart';
import '../widgets/note_card.dart';

class Archive extends StatefulWidget {
  @override
  State<Archive> createState() => _ArchiveState();

  const Archive({Key? key}) : super(key: key);
}

class _ArchiveState extends State<Archive> {
  List<Note> notesList = [];

  @override
  Widget build(BuildContext context) {
    notesList = selectArchiveNotes(context.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Archive"),
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
    );
  }
}
