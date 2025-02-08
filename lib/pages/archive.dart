import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/new_note.dart';
import 'package:simple_note_taker/service/note_service.dart';
import '../class/note.dart';
import '../db/note_dao.dart';
import '../util/app_details.dart';
import '../widgets/note_card.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List<Note> notesList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notesList = await NoteService().queryAllRowsDescByArchivedValue(1);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Archive"),
      ),
      body: loading
          ? const Center(child: SizedBox.shrink())
          : ListView(
              children: [
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notesList.length,
                  itemBuilder: (context, int index) {
                    Note note = notesList[index];

                    return NoteCard(key: UniqueKey(), refreshHome: loadNotes, index: index, note: note);
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
