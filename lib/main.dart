import 'package:flutter/material.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:my_notes/screens/add_note_screen.dart';
import 'package:my_notes/screens/edit_note_screen.dart';
import 'package:my_notes/screens/important_notes.dart';
import 'package:my_notes/screens/note_detail_screen.dart';
import 'package:my_notes/screens/splash_screen.dart';
import 'package:my_notes/widgets/app_drawer.dart';
import 'package:my_notes/widgets/note_card.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          NoteDetailScreen.routeName: (context) => const NoteDetailScreen(),
          AddNoteScreen.routeName: (context) => const AddNoteScreen(),
          SplashScreen.routeName: (context) => const SplashScreen(),
          EditNoteScreen.routeName: (context) => EditNoteScreen(),
          ImportantNotes.routeName: (context) => const ImportantNotes(),
        },
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddNoteScreen.routeName);
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade800, width: 1.5)),
                label: const Text(
                  'Add Note',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          )
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(AddNoteScreen.routeName);
          //     },
          //     icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<NotesProvider>(context, listen: true)
            .fetchAndSetNotes(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<NotesProvider>(
                child: const Center(
                    child: Text('Got no notes yet! Start adding some.')),
                builder: (ctx, snapNotes, ch) => snapNotes.notes.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: snapNotes.notes.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(snapNotes.notes[index].id),
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
                                  .deleteNote(snapNotes.notes[index].id);
                            },
                            child: NoteCard(
                                snapNotes.notes[index].id,
                                snapNotes.notes[index].title,
                                snapNotes.notes[index].note,
                                snapNotes.notes[index].time),
                          );
                        }),
              ),
      ),
    );
  }
}
