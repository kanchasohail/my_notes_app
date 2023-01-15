import 'package:flutter/material.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatelessWidget {
  static const routeName = '/edit-note-screen';

  EditNoteScreen({super.key});

  final _titleController = TextEditingController();

  final _noteController = TextEditingController();

  void _updateNote(String id, String title, String note, BuildContext ctx) {
    if (title.trim().isNotEmpty && note.trim().isNotEmpty) {
      Provider.of<NotesProvider>(ctx, listen: false)
          .updateNote(id, title, note);
      Navigator.of(ctx).pop();

      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Updated successfully !')));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Theme.of(ctx).errorColor,
          content: const Text('Please Enter title and a note')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context)?.settings.arguments;
    final noteData =
        Provider.of<NotesProvider>(context).fetchAndShowNote(noteId.toString());
    _titleController.text = noteData.title;
    _noteController.text = noteData.note;
    return Scaffold(
      appBar: AppBar(
        // title: Text('Edit ....$noteId'),
        title: Text('Edit.. ${noteData.title}'),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(12),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  maxLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                TextField(
                  // keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  controller: _noteController,
                  decoration: const InputDecoration(hintText: 'Your note'),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      _updateNote(noteData.id, _titleController.text.toString(),
                          _noteController.text.toString(), context);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
