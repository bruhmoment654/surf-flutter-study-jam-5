
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text('Create'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pushNamed(context, '/create');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text('Templates'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pushNamed(context, '/templates');
              },
            ),
          ),
        ],
      ),
    );
  }
}
