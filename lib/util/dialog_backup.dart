import 'package:flutter/material.dart';

import 'app_details.dart';
import 'backup_utils.dart';

class DialogBackup extends StatefulWidget {
  @override
  State<DialogBackup> createState() => _DialogBackupState();

  const DialogBackup({Key? key, required this.isCreateBackup}) : super(key: key);

  final bool isCreateBackup;
}

class _DialogBackupState extends State<DialogBackup> {
  Future<void> _createBackup() async {
    await BackupUtils().backupData(AppDetails.backupFileName);
  }

  Future<void> _restoreFromBackup() async {
    await BackupUtils().restoreBackupData(AppDetails.backupFileName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Confirm",
      ),
      content: Text(
        widget.isCreateBackup ? "Create backup ?" : "Restore backup ?",
      ),
      actions: [
        TextButton(
          child: const Text(
            "Yes",
          ),
          onPressed: () {
            if (widget.isCreateBackup) {
              Navigator.of(context).pop();
              _createBackup();
            } else {
              Navigator.of(context).pop();
              _restoreFromBackup();
            }
          },
        )
      ],
    );
  }
}
