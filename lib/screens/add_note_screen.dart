import 'package:flutter/material.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/add_note_form.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);
  static const routeName = '/add-note-screen';

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

void _submitNote(String title, String note, BuildContext ctx) {
  if (title.trim().isNotEmpty && note.trim().isNotEmpty) {
    Provider.of<NotesProvider>(ctx, listen: false).addNote(title, note);
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
      content: Text('Saved Successfully'),
      backgroundColor: Colors.green,
    ));
    Navigator.of(ctx).pop();
  } else {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: const Text('Enter note and title'),
      backgroundColor: Theme.of(ctx).errorColor,
    ));
    return;
  }
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: SingleChildScrollView(child: AddNoteForm(_submitNote)),
    );
  }
}
