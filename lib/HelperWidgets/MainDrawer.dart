import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import '../screens/note_screen.dart';
import '../screens/search_screen.dart';
import 'HelperWidgets.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  MainDrawerState createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.blue[50]?.withOpacity(.5),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset("assets/insta.png",height: 100,),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              HelperWidgets().drawerTiles(
                  title: "Info",
                  iconData: Icons.info_sharp,
                  isOffline: false,
                  onTap: () { }),
              HelperWidgets().drawerTiles(
                  title: "Version History",
                  iconData: Icons.upcoming,
                  isOffline: false,
                  onTap: () { }),
              HelperWidgets().drawerTiles(
                  title: "Mahipal Notes",
                  iconData: Icons.location_city_rounded,
                  isOffline: false,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              HelperWidgets().drawerTiles(
                  title: "Search Item",
                  iconData: Icons.work,
                  isOffline: false,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchNotes()));
                    setState(() {});

                  }),
              HelperWidgets().drawerTiles(
                  title: "Add Notes",
                  iconData: Icons.event,
                  isOffline: false,
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => const NoteScreen()));
                    setState(() {});
                  }),
              HelperWidgets().drawerTiles(
                  title: "Users",
                  iconData: Icons.assessment,
                  isOffline: false,
                  onTap: () {}),
              HelperWidgets().drawerTiles(
                  title: "Product",
                  iconData: CupertinoIcons.doc_fill,
                  isOffline: false,
                  onTap: () {}),
              HelperWidgets().drawerTiles(
                  title: "Safety Programs",
                  iconData: Icons.security,
                  isOffline: false,
                  onTap: () async {}),
              HelperWidgets().drawerTiles(
                  title: "Log Out",
                  iconData: Icons.power_settings_new,
                  isOffline: true,
                  onTap: () async {}),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }

}
