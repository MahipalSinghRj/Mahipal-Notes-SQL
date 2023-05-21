import 'package:flutter/material.dart';
import '../HelperWidgets/HelperWidgets.dart';
import '../models/note_model.dart';
import '../services/database_helper.dart';
import '../widgets/note_widget.dart';
import 'note_screen.dart';

class SearchNotes extends StatefulWidget {
  const SearchNotes({Key? key}) : super(key: key);

  @override
  State<SearchNotes> createState() => _SearchNotesState();
}

class _SearchNotesState extends State<SearchNotes> {
  final searchNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Search Notes'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: HelperWidgets().textFormFieldWithSearch(searchNotesController, 1, "Type here", "Search Fields", (value) {
                setState(() {});
              }),
            ),
            Expanded(
              child: FutureBuilder<List<Note>?>(
                future: DatabaseHelper().searchFilterWithMultipleItem(searchKeyword: searchNotesController.text),
                builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
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
