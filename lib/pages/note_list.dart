import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/save_note.dart';

import '../class/note.dart';
import '../db/note_dao.dart';
import '../widgets/playlist_tile.dart';

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
    getAllPlaylists(false);
    super.initState();
  }

  void getAllPlaylists([bool refresh = true]) async {
    if (refresh) {
      setState(() {
        loading = true;
      });
    }
    var resp = await dbPlaylist.queryAllRows();
    setState(() {
      loading = false;
      playlists = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 650),
          child: loading
              ? const Center(child: SizedBox.shrink())
              : ListView(
                  children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 4,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, int index) {
                        return PlaylistTile(
                          key: UniqueKey(),
                          refreshHome: getAllPlaylists,
                          playlist: Note(
                            idNote: playlists[index]['id_note'],
                            title: playlists[index]['title'],
                            text: playlists[index]['text'],
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
                          refreshHome: getAllPlaylists,
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
