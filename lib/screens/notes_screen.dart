import 'package:flutter/material.dart';
import '../HelperWidgets/HelperWidgets.dart';
import '../HelperWidgets/HighlightTextField.dart';
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
  final searchController=TextEditingController();
  //final todoList=DatabaseHelper().searchList;
  List<Note> todoList = [];
  List<Note> foundTodo = [];

  @override
  void initState() {
     super.initState();
     fetchAllNotes();
  }

  Future<void> fetchAllNotes() async {
    todoList = (await DatabaseHelper().getAllNotes())!;
    foundTodo = todoList;
  }

  // Rest of your code...

  // void runFilter(String enteredKeyword) {
  //   if (enteredKeyword.isEmpty) {
  //     setState(() {
  //       foundTodo = todoList;
  //     });
  //   } else {
  //     final results = todoList.where(
  //           (item) => item.title.toLowerCase().contains(enteredKeyword.toLowerCase()),
  //     ).toList();
  //     setState(() {
  //       foundTodo = results;
  //     });
  //   }
  // }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        foundTodo = todoList;
      });
    } else {
      final results = todoList.where((item) {
        final titleMatch = item.title.toLowerCase().contains(enteredKeyword.toLowerCase());
        final habitsMatch = item.habits.toLowerCase().contains(enteredKeyword.toLowerCase());
        final descriptionMatch = item.description.toLowerCase().contains(enteredKeyword.toLowerCase());
        final addressMatch = item.address.toLowerCase().contains(enteredKeyword.toLowerCase());

        return titleMatch || habitsMatch || descriptionMatch || addressMatch;
      }).toList();

      setState(() {
        foundTodo = results;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Mahipal Notes'),
          centerTitle: true
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const NoteScreen()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
              child: HelperWidgets().textFormFieldWithSearch(searchController, 1, "Type here", "Search Fields", (value) {
                setState(() {
                  runFilter(value);
                });
              }),
            ),
            Expanded(
              child: FutureBuilder<List<Note>?>(
                future: DatabaseHelper().getAllNotes(),
                builder: (context, AsyncSnapshot<List<Note>?> snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemCount: foundTodo.length,
                        //itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => NoteWidget(
                           note: foundTodo[index],
                          //note: snapshot.data![index],
                          onTap: () async {
                            await Navigator.push(
                                context, MaterialPageRoute(builder: (context) => NoteScreen(note: snapshot.data![index])));
                            setState(() {});
                          },
                          onLongPress: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return HelperWidgets().showDialogWidget(
                                      onPressFunction: () async {
                                        await DatabaseHelper.deleteNote(snapshot.data![index]);
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
        ));
  }

}