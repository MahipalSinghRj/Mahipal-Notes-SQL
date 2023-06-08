import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_notes/screens/search_screen.dart';
import '../Controllers/UserController.dart';
import '../HelperWidgets/HelperWidgets.dart';
import '../HelperWidgets/MainDrawer.dart';
import '../models/note_model.dart';
import '../services/database_helper.dart';
import '../widgets/note_widget.dart';
import 'note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final searchController = TextEditingController();
  List<Note> getAllNotes = [];
  List<Note> searchList = [];
  UserDetailsController userDetailsController =
      Get.put(UserDetailsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userDetailsController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        ///Main App bar
        appBar: AppBar(
          title: const Text('Mahipal Notes'),
          centerTitle: true,
          leading: GestureDetector(
              onDoubleTap: () {
                Navigator.pop(context);
              },
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(Icons.menu)),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SearchNotes()));
                },
                child: const Icon(Icons.search)),
            const SizedBox(width: 20)
          ],
        ),

        ///Floating button
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NoteScreen()));
              setState(() {});
            },
            child: const Icon(Icons.add)),

        ///Opening section
        body: Scaffold(
            backgroundColor: Colors.grey[200],
            key: _scaffoldKey,
            drawer: const MainDrawer(),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Note>?>(
                    future: DatabaseHelper().getAllNotes(),
                    builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Center(child: CircularProgressIndicator()));
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => NoteWidget(
                              note: snapshot.data![index],
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NoteScreen(
                                            note: snapshot.data![index])));
                                setState(() {});
                              },
                              onLongPress: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return HelperWidgets().showDialogWidget(
                                          onPressFunction: () async {
                                            await DatabaseHelper.deleteNote(
                                                snapshot.data![index]);
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          context: context);
                                    });
                              },
                            ),
                          );
                        }
                      }
                      return Center(child: HelperWidgets().noData());
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
