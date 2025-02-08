import 'package:flutter/material.dart';
import 'package:simple_note_taker/pages/archive.dart';
import 'package:simple_note_taker/util/app_details.dart';
import '../class/note.dart';
import '../service/note_service.dart';
import '../widgets/note_card.dart';
import 'configs/settings.dart';
import 'new_note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notesList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    notesList = await NoteService().queryAllRowsDescByArchivedValue(0);

    setState(() {
      loading = false;
    });
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
                      builder: (BuildContext context) => Settings(
                        refreshHome: _loadNotes,
                      ),
                    ));
              }),
        ],
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

                    return NoteCard(key: UniqueKey(), refreshHome: _loadNotes, index: index, note: note);
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
                builder: (BuildContext context) => NewNote(
                  refreshHome: _loadNotes,
                ),
              ));
        },
        child: const Icon(
          Icons.add_outlined,
        ),
      ),
    );
  }
}
