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
  List<Map<String, dynamic>> playlists = [];
  final dbPlaylist = NoteDao.instance;
  bool loading = true;

  @override
  void initState() {
    getAllNotes(false);
    super.initState();
  }

  void getAllNotes([bool refresh = true]) async {
    if (refresh) {
      setState(() {
        loading = true;
      });
    }
    var resp = await dbPlaylist.queryAllRowsDescArchive(widget.archivedValue);
    setState(() {
      loading = false;
      playlists = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: loading
              ? const Center(child: SizedBox.shrink())
              : ListView(
                  children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 0,),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, int index) {
                        return NoteTile(
                          key: UniqueKey(),
                          refreshHome: getAllNotes,
                          note: Note(
                            idNote: playlists[index]['id_note'],
                            title: playlists[index]['title'],
                            text: playlists[index]['text'],
                            archived: playlists[index]['archived'],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
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
                child: Icon(
                  Icons.add_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : null);
  }
}
