import 'package:jiffy/jiffy.dart';

class Note {
  int? id;
  String? title;
  String? text;
  int? archived;
  String? creationDate;

  Note({this.id, this.title, this.text, this.archived, this.creationDate});

  String get formattedCreationDate => Jiffy.parse(creationDate!).format(pattern: 'dd/MM/yyyy');

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      archived: map['archived'],
      creationDate: map['creationDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'archived': archived,
      'creationDate': creationDate,
    };
  }

}
