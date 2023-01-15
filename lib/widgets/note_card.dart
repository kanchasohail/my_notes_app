import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_notes/screens/note_detail_screen.dart';

import 'components/custom_card_shape_painter.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(this.id, this.title, this.notePrev, this._dateTime, {super.key});

  final String id;

  final String title;

  final String notePrev;

  final DateTime _dateTime ;

  final double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed(NoteDetailScreen.routeName, arguments: id),
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
                            title,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          Text(notePrev,
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
                              onPressed: () => print('Star pressed ********'),
                              icon: const Icon(
                                Icons.star,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(DateFormat('dd/MM/yy').format(_dateTime) , style: const TextStyle(
                              fontStyle: FontStyle.italic , fontWeight: FontWeight.w500
                            ),),
                            Text(DateFormat('hh:mm a').format(_dateTime) , style: TextStyle(
                              fontWeight: FontWeight.bold , color: Colors.blueGrey.shade800
                            ),),
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
