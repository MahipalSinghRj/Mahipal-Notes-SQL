import 'package:flutter/material.dart';
import '../HelperWidgets/HelperWidgets.dart';
import '../models/note_model.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const NoteWidget({Key? key, required this.note, required this.onTap, required this.onLongPress}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Card(
          elevation: 4, // The elevation or shadow depth of the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // The border radius of the card
            side: const BorderSide(
              color: Colors.grey, // The color of the card's border
              width: 1, // The width of the card's border
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("${note.id}. Date & Time : ${note.date}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
                  ],
                ),

                HelperWidgets().divider(),

                Text("Title name is : ${note.title}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                HelperWidgets().divider(),

                Text("Habits : ${note.habits}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),

                HelperWidgets().divider(),

                Text("Address : ${note.address}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),

                HelperWidgets().divider(),

                Text("Description is : ${note.description}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
