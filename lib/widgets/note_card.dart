import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/providers/notes_provider.dart';

import 'package:my_notes/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';

import 'components/custom_card_shape_painter.dart';

class NoteCard extends StatefulWidget {
  NoteCard(this.id, this.title, this.notePrev, this._dateTime, this.important,
      {super.key});

  final String id;

  final String title;

  final String notePrev;

  final DateTime _dateTime;

  bool important;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  final double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed(NoteDetailScreen.routeName, arguments: widget.id),
          child: Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pink, Colors.red]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.red,
                          blurRadius: 12,
                          offset: Offset(0, 8))
                    ]),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: CustomPaint(
                  size: const Size(100, 150),
                  painter: CustomCardShapePainter(
                      _borderRadius, Colors.pink, Colors.red),
                ),
              ),
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/images/photo.png',
                          height: 60,
                          width: 60,
                        )),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          Text(widget.notePrev,
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.important = !widget.important;
                                });
                                Provider.of<NotesProvider>(context,
                                        listen: false)
                                    .shuffleImportant(
                                        widget.id, widget.important);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(seconds: 2),
                                  content: Text(widget.important
                                      ? 'Marked as Important'
                                      : 'Removed from Important'),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ));
                              },
                              icon: Icon(
                                widget.important
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                size: 40,
                                color: widget.important
                                    ? Colors.yellowAccent
                                    : Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateFormat('dd/MM/yy').format(widget._dateTime),
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(widget._dateTime),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade800),
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
