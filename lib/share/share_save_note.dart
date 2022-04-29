import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ShareSaveNote extends StatefulWidget {
  @override
  _ShareSaveNoteState createState() => _ShareSaveNoteState();

  String? sharedText = "";

  ShareSaveNote({Key? key, this.sharedText}) : super(key: key);
}

class _ShareSaveNoteState extends State<ShareSaveNote> {
  TextEditingController controllerPlaylistTitle = TextEditingController();
  TextEditingController controllerArtist = TextEditingController();
  TextEditingController controllerTags = TextEditingController();
  TextEditingController controllerLink = TextEditingController();


  @override
  void initState() {
    controllerLink.text = widget.sharedText!;
    super.initState();
  }

  /*Future<void> _savePlaylist() async {
    Map<String, dynamic> row = {
      PlaylistDao.columnLink: controllerLink.text,
      PlaylistDao.columnTitle: controllerPlaylistTitle.text,
      PlaylistDao.columnArchived: 0,
      PlaylistDao.columnArtist: controllerArtist.text,
      PlaylistDao.columnTags: controllerTags.text,
    };
    final id = await dbPlaylist.insert(row);
  }*/

  String checkErrors() {
    String erros = "";
    if (controllerLink.text.isEmpty) {
      erros += "Insert link\n";
    }
    if (controllerPlaylistTitle.text.isEmpty) {
      erros += "Insert title\n";
    }
    return erros;
  }

  showAlertDialogErrors(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Error",
          ),
          content: Text(
            checkErrors(),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Ok",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _loseFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {

    final Color? bottomOverlayColor =
        Theme.of(context).bottomNavigationBarTheme.backgroundColor;
    final Color? topOverlayColor =
        Theme.of(context).appBarTheme.backgroundColor;
    final Brightness iconBrightness =
    Theme.of(context).brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarColor: bottomOverlayColor,
        statusBarColor: topOverlayColor,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            _loseFocus();
          },
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Save Shared Playlist'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh_outlined),
                    tooltip: 'Load data',
                    onPressed: () {

                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(Icons.save_outlined),
                    tooltip: 'Save',
                    onPressed: () {
                      if (checkErrors().isEmpty) {
                        /*_savePlaylist().then((v) => {
                              Navigator.of(context).pop(),
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const App()),
                                (Route<dynamic> route) => false,
                              )
                            });*/
                      } else {
                        showAlertDialogErrors(context);
                      }
                    },
                  ),
                ],
              ),
              body: ListView(children: [

                ListTile(
                  title: Text("Link",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    maxLength: 500,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: controllerLink,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.link_outlined),
                      helperText: "* Required",
                      counterText: "",
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Title",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 300,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: controllerPlaylistTitle,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.notes_outlined),
                      helperText: "* Required",
                      counterText: "",
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Artist",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 300,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: controllerArtist,
                    decoration: const InputDecoration(
                      counterText: "",
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Tags",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 300,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: controllerTags,
                    decoration: const InputDecoration(
                      counterText: "",
                      prefixIcon: Icon(
                        Icons.sell_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ])),
        ),
      ),
    );
  }
}
