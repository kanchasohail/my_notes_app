import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<NotesProvider>(context).fetchAndSetNotes() ;
    Timer(const Duration(seconds: 2), () {
     Navigator.popAndPushNamed(context, '/');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
