import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/auth/signin.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/services/api_service.dart' as api;

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
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.deepPurple
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: NetworkImage('https://steamuserimages-a.akamaihd.net/ugc/2053129740384007681/008613159A03A2D9A1A38C0F66FC3F3CBCF73C9C/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false')                  ),
                      ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(api.user, style: TextStyle(color: Colors.white),),
                ],
              ),
            ],
          )
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.home),
          title: const Text("Accueil"),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Home(),
              )
            );
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.add),
          title: const Text("Creation"),
            onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Create(),
                )
            );
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout),
          title: const Text("Déconnexion"),
          onTap: () async {
            try{
              var response = await api.signout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Signin(),
                  )
              );
            }on DioException catch (e) {
              print(e);
              String message = e.response!.data;
              if (message == "BadCredentialsException") {
                print('login deja utilise');
              } else {
                print('autre erreurs');
              }
            }
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