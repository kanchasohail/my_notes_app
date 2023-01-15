import 'package:flutter/material.dart';
import 'package:my_notes/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/notes_provider.dart';
import '../widgets/note_card.dart';

class ImportantNotes extends StatefulWidget {
  static const routeName = '/important-notes';
  const ImportantNotes({Key? key}) : super(key: key);

  @override
  State<ImportantNotes> createState() => _ImportantNotesState();
}

class _ImportantNotesState extends State<ImportantNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Important Notes'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<NotesProvider>(context, listen: true)
            .fetchAndSetImportantNotes(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<NotesProvider>(
          child: const Center(
              child: Text('Got no important notes yet! Start marking some.')),
          builder: (ctx, snapNotes, ch) => snapNotes.importantNotes.isEmpty
              ? ch!
              : ListView.builder(
              itemCount: snapNotes.importantNotes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(snapNotes.importantNotes[index].id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Are you sure ?'),
                            content: const Text(
                                'Are you sure to delete this note ?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('No')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Yes')),
                            ],
                          );
                        });
                  },
                  onDismissed: (direction) {
                    Provider.of<NotesProvider>(context, listen: false)
                        .deleteNote(snapNotes.importantNotes[index].id);
                  },
                  child: NoteCard(
                      snapNotes.importantNotes[index].id,
                      snapNotes.importantNotes[index].title,
                      snapNotes.importantNotes[index].note,
                      snapNotes.importantNotes[index].time,
                      snapNotes.importantNotes[index].important),
                );
              }),
        ),
      ),
    );
  }
}
