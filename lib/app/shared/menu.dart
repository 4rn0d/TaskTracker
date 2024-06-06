import 'package:flutter/material.dart';
import 'package:tp1/app/auth/signin.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/task/create.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 200,
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.home),
          title: const Text("Accueil"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.add),
          title: const Text("Creation"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Create(),
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout),
          title: const Text("Déconnexion"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Signin(),
              ),
            );
          },
        ),
      ],
    );

    return Drawer(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }
}