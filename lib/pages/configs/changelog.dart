import 'package:flutter/material.dart';

import '../../util/app_details.dart';

class Changelog extends StatelessWidget {
  const Changelog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Changelog"),
        ),
        body: ListView(children: <Widget>[
          ListTile(title: Text("Current Version", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: themeColorApp))),
          ListTile(
            title: Text(
              AppDetails.changelogCurrent,
            ),
          ),
          ListTile(
            title: Text("Previous Versions", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: themeColorApp)),
          ),
          ListTile(
            title: Text(
              AppDetails.changelogsOld,
            ),
          ),
        ]));
  }
}
