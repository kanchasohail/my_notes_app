import 'package:flutter/material.dart';

class AddNoteForm extends StatelessWidget {
  AddNoteForm(this._sendForm, {super.key});

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  final Function _sendForm ;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  _sendForm(_titleController.text.toString() , _noteController.text.toString() , context);
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
