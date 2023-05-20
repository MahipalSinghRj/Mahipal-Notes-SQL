import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/database_helper.dart';

class HelperWidgets {
  DatabaseHelper databaseHelper=DatabaseHelper();

  AlertDialog showDialogWidget({required Function() onPressFunction, required BuildContext context}) {
    return AlertDialog(
      title: const Text('Are you sure you want to delete this note?'),
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
          onPressed: onPressFunction,
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
      ],
    );
  }

  ElevatedButton elevatedButton({required Function() onPress, required String text}) {
    return ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 0.75),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )))),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ));
  }

  Padding simpleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  TextFormField textFormField(TextEditingController controller, int maxLine, String hintText, labelTitle) {
    return TextFormField(
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelTitle,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.75),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ))),
    );
  }

  TextFormField textFormFieldWithSearch(TextEditingController controller, int maxLine, String hintText, labelTitle, Function(String) onChanged) {
    return TextFormField(
      controller: controller,
      maxLines: maxLine,onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelTitle,prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.75),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ))),
    );
  }

  Padding divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  void snackBarMessage({required String message, required Color iconColor}) {
    Get.snackbar(
      "this is title",
      "this is my message",
      messageText: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontFamily: "Adelle"),
      ),
      titleText: const Text(
        "Notification : ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue, fontFamily: "Adelle"),
      ),
      leftBarIndicatorColor: Colors.blue,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 6,
      margin: const EdgeInsets.all(8),
      duration: const Duration(milliseconds: 2000),
      // barBlur: barBlur,
      backgroundColor: Colors.white,
      icon: Icon(
        Icons.info_outline_rounded,
        color: iconColor,
        size: 30,
      ),
      shouldIconPulse: false,
      borderColor: Colors.blue,
      borderWidth: .1,

      isDismissible: true,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastOutSlowIn,
      reverseAnimationCurve: Curves.bounceInOut,
      animationDuration: const Duration(milliseconds: 250),
      overlayBlur: 0.5,
    );
  }

  Widget noData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(
          const AssetImage('assets/noData.png'),
          size: 40,
          color: Colors.red.withOpacity(.8),
        ),
        const Text(
          "No Records Available",
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w300, fontFamily: "Adelle"),
        ),
      ],
    );
  }
}
