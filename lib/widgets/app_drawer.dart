import 'package:flutter/material.dart';
import 'package:my_notes/screens/important_notes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 110,
            color: Theme.of(context).primaryColor,
            child: const Center(
                child: Text(
              'My Notes !',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            )),
          ),
          InkWell(
            onTap: () {
              print('Home clicked');
              Navigator.pushReplacementNamed(context, '/');
              },
            child: Card(
              elevation: 7,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                width: double.infinity,
                child: Row(
                  children: const [
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.home_filled,
                      size: 25,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('ONly Important clicked');
              Navigator.pushReplacementNamed(context, ImportantNotes.routeName);
              },
            child: Card(
              elevation: 7,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                width: double.infinity,
                child: Row(
                  children: [
                    const Text(
                      'Only Important',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.orangeAccent.shade400,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
