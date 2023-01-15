import 'package:flutter/material.dart';
import 'package:my_notes/widgets/app_drawer.dart';

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
      body: Text('Only Important'),
    );
  }
}
