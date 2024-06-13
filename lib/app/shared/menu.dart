import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/auth/signin.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/app/utils/app_theme.dart';
import 'package:tp1/generated/l10n.dart';

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
            color: AppTheme.accentColor
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
                  Text(api.user, style: const TextStyle(color: Colors.white),),
                ],
              ),
            ],
          )
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.home),
          title: Text(S.of(context).title_home),
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
          title: Text(S.of(context).title_create),
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
          title: Text(S.of(context).title_signout),
          onTap: () async {
            try{
              setState(() {
                api.isLoading = true;
              });
              var response = await api.signout();
              api.isLoading = false;
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