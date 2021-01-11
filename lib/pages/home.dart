import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../services/theme_changer.dart';
import '../tabs/categories_tab.dart';
import '../tabs/home_tab.dart';
import './single_category.dart';
import '../model/post.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final keyIsFirstLoaded = 'is_first_loaded';

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
//      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
//        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Image.asset('images/LogoTMHorizontal.png', height: 40.0,),
        titleSpacing: 8.0,
        actions: <Widget>[
//          GestureDetector(
//            child: Icon(Icons.lightbulb_outline),
//            onTap: themeChanger.toggle,
//          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  DrawerHeader(
                    child: Container(
                        height: 142,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "images/LogoTM.png",
                        )),
                    decoration: BoxDecoration(
//                      color: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Fan APP - No es la APP oficial de TeleMedellín",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9.0,
                    ),
                  ),
                  Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          ListTile(
//                            leading: Icon(MdiIcons.fromString('lightbulb-outline')),
                            title: Text('Antioquia'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(34, "Antioquia");
                            },
                          ),
                          ListTile(
                            title: Text('Colombia'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(25, "Colombia");
                            },
                          ),
                          ListTile(
                            title: Text('Cultura'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(28, "Cultura");
                            },
                          ),
                          ListTile(
                            title: Text('Deportes'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(30, "Deportes");
                            },
                          ),
                          ListTile(
                            title: Text('Internacional'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(24, "Internacional");
                            },
                          ),
                          ListTile(
                            title: Text('Medellín'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(33, "Medellín");
                            },
                          ),
                          ListTile(
                            title: Text('Telemedellín'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(1, "Telemedellín");
                            },
                          ),
                          ListTile(
                            title: Text('Valle de Aburrá'),
                            onTap: () {
                              Navigator.pop(context);
                              _go2Category(53, "Valle de Aburrá");
                            },
                          ),
                        ],
                      ),
                  ),



                ],
              )
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 35.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(MdiIcons.fromString('lightbulb-outline')),
                            title: Text('Cambiar tema'),
                            onTap: () {
                              setState(() {
                                themeChanger.toggle();
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                              leading: Icon(MdiIcons.fromString('contacts-outline')),
                              title: Text('¿Eres de TeleMedellín?'),
                              onTap: (){
                                Navigator.pop(context);
                                _showDialog();
                              },
                          ),
                          Text('Hecho con ❤️ en Medellín'),
                        ],
                      ),
                    )
                )
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: <Widget>[
          HomeTab(),
          CategoriesTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon:
                Icon(MdiIcons.fromString('newspaper-variant-multiple-outline')),
            title: Text('Noticias'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(MdiIcons.fromString('notification-clear-all')),
            title: Text('Categorías'),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    super.initState();
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
//          title: new Text("Alert Dialog title"),
          content: new Text(
            "Esta APP ha sido desarrollada con ❤ por un televidente de TeleMedellín con el único fin de extender el reconocimiento de la marca, por tal motivo la APP no tiene publicidad y es completamente sin fines de lucro. Si eres parte de TeleMedellín puedes comunicarte vía mail al presionar el botón 'Contactar'.",
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Contactar"),
              onPressed: () async {
                Navigator.of(context).pop();
                _launchMail();
              },
            ),
          ],
        );
      },
    );
  }
  _launchMail() async {
    Email email = Email(
        to: ['snowf4all@protonmail.com'],
        subject: 'Soy de TeleMedellín y deseo contactarte',
    );
    await EmailLauncher.launch(email);
  }
  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alerta de responsabilidad"),
            content: new Text(
                "Esta APP ha sido desarrollada con ❤ por un televidente de TeleMedellín con el único fin de extender el reconocimiento de la marca y no es la aplicación oficial de TeleMedellín, por tal motivo la APP no tiene publicidad y es completamente sin fines de lucro. Si haces parte de TeleMedellín y quieres ponerte en contacto para que sea la aplicación oficial del noticiero puedes contactarte usando el botón que se encuentra en el Menú '¿Eres de TeleMedellín?'.",
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Aceptar"),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                },
              ),
            ],
          );
        },
      );
    }
  }
  void _go2Category(int id, String name) {
    PostCategory category = PostCategory(name: name, id: id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCategory(category)));
  }

}
