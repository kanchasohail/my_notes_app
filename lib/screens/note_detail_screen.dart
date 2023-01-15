import 'package:flutter/material.dart';
import 'package:my_notes/screens/edit_note_screen.dart';
import 'package:provider/provider.dart';

import '../providers/notes_provider.dart';

class NoteDetailScreen extends StatefulWidget {
  static const routeName = '/note-detail-screen';

  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final argsId = ModalRoute.of(context)?.settings.arguments;
    final note = Provider.of<NotesProvider>(context, listen: false)
        .fetchAndShowNote(argsId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [IconButton(onPressed: () {
          // Navigator.of(context).pushNamed(EditNoteScreen.routeName , arguments: note.id);
          Navigator.of(context).popAndPushNamed(EditNoteScreen.routeName , arguments: note.id);
        }, icon: const Icon(Icons.edit))],
      ),
      body: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(24))),
          shadowColor: Colors.red,
          elevation: 7,
          margin: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(24)),
                gradient: LinearGradient(
                    colors: [Colors.yellowAccent, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                note.note,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          )),
    );
  }
}
