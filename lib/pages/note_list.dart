import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/save_note.dart';
import '../class/note.dart';
import '../db/note_dao.dart';
import '../widgets/note_tile.dart';

class NoteList extends StatefulWidget {
  int archivedValue;

  NoteList({Key? key, required this.archivedValue}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Map<String, dynamic>> notesList = [];
  final dbNotes = NoteDao.instance;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  void getAllNotes() async {
    notesList = await dbNotes.queryAllRowsDescArchive(widget.archivedValue);
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
                  ListView.builder(
                    //separatorBuilder: (BuildContext context, int index) => const Divider(),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notesList.length,
                    itemBuilder: (context, int index) {
                      return NoteTile(
                        key: UniqueKey(),
                        refreshHome: getAllNotes,
                        index: index,
                        note: Note(
                          idNote: notesList[index]['id_note'],
                          title: notesList[index]['title'],
                          text: notesList[index]['text'],
                          archived: notesList[index]['archived'],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 75,
                  )
                ],
              ),
        floatingActionButton: widget.archivedValue == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SaveNote(
                          refreshHome: getAllNotes,
                        ),
                      ));
                },
                child: const Icon(
                  Icons.add_outlined,
                ),
              )
            : null);
  }
}
