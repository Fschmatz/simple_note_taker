import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/save_note.dart';
import 'package:simple_note_taker/service/note_service.dart';
import '../class/note.dart';
import '../widgets/note_card.dart';

class NotesList extends StatefulWidget {
  NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<Note> notesList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notesList = await NoteService().queryAllRowsDescByArchivedValue(0);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(
                children: [
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(
                      height: 8,
                    ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SaveNote(
                    refreshHome: loadNotes,
                  ),
                ));
          },
          child: const Icon(
            Icons.add_outlined,
          ),
        ));
  }
}
