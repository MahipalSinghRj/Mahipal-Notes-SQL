import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Global/Gobal.dart';
import '../HelperWidgets/HelperWidgets.dart';
import '../models/note_model.dart';
import '../services/database_helper.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

    NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final habitsController = TextEditingController();
  final addressController = TextEditingController();

  String titleName = '';
  bool isBool=true;
  GlobalController globalController = Get.put(GlobalController());



  @override
  void initState() {
    super.initState();
    setData();
  }

  setData(){
    if(widget.note != null){
      titleController.text = widget.note!.title;
      habitsController.text = widget.note!.habits;
      addressController.text = widget.note!.address;
      descriptionController.text = widget.note!.description;
    }
  }

  bool validateFields() {
    final title = titleController.text;
    final description = descriptionController.text;
    final habits = habitsController.text;
    final address = addressController.text;
    if (title.isEmpty || description.isEmpty || habits.isEmpty || address.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.note == null ? 'Add a note' : 'Edit note'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(
          children: [
            HelperWidgets().simpleText('What are you thinking? Note here') ,
            HelperWidgets().textFormField(titleController, 1, 'Title', 'Note title'),
            const SizedBox(height: 20),
            HelperWidgets().textFormField(habitsController, 1, 'Type here the habits', 'Habits description'),
            const SizedBox(height: 20),
            HelperWidgets().textFormField(addressController, 1, 'Type here address ', 'Address description'),
            const SizedBox(height: 20),
            HelperWidgets().textFormField(descriptionController, 5, 'Type here the note', 'Note description'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: HelperWidgets().elevatedButton(
                    onPress: () async {
                      if (!validateFields()) {
                        return HelperWidgets()
                            .snackBarMessage(message: 'Please fill all the details', iconColor: Colors.redAccent);
                      }
                      final title = titleController.text;
                      final description = descriptionController.text;
                      final habits = habitsController.text;
                      final address = addressController.text;
                      DateTime now = DateTime.now();
                      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                      final Note model = Note(
                          title: title,
                          description: description,
                          id: widget.note?.id,
                          habits: habits,
                          address: address,
                          date: formattedDateTime);
                      setState(() {
                        titleName = title;
                      });
                      if (widget.note == null) {
                        await globalController.setTitleName(titleName: title);

                        await DatabaseHelper.addNote(model);
                        setState(() {

                        });
                      } else {
                        await DatabaseHelper.updateNote(model);
                        setState(() {

                        });
                      }
                      titleController.clear();
                      descriptionController.clear();
                      habitsController.clear();
                      addressController.clear();
                      Future.delayed(const Duration(seconds: 1), () {
                        Get.back();
                      });
                    },
                    text: widget.note == null ? 'Save' : 'Edit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
