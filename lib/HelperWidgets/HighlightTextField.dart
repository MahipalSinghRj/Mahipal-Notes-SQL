import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HighlightedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String searchText;
  final Function(String) onChanged;

    HighlightedTextField({
    required this.controller,
    required this.hintText,
    required this.searchText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final String value = controller.text;

    List<TextSpan> textSpans = [];

    if (value.isNotEmpty && searchText.isNotEmpty) {
      final RegExp regex = RegExp(searchText, caseSensitive: false);
      final Iterable<Match> matches = regex.allMatches(value);

      int previousEnd = 0;
      for (Match match in matches) {
        final String preMatch = value.substring(previousEnd, match.start);
        final String searchMatch = value.substring(match.start, match.end);

        if (preMatch.isNotEmpty) {
          textSpans.add(TextSpan(text: preMatch));
        }

        textSpans.add(
          TextSpan(
            text: searchMatch,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );

        previousEnd = match.end;
      }

      if (previousEnd < value.length) {
        textSpans.add(TextSpan(text: value.substring(previousEnd)));
      }
    } else {
      textSpans = [TextSpan(text: value)];
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,

      style: TextStyle(fontSize: 16),
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Colors.blue, // Customize the cursor color here
      buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      inputFormatters: [],
      autofocus: false,
      autocorrect: false,
      enableSuggestions: false,
      enableInteractiveSelection: true,
      toolbarOptions: ToolbarOptions(
        copy: true,
        selectAll: true,
        cut: false,
        paste: false,
      ),
      focusNode: null,
      readOnly: false,
      obscuringCharacter: '•',

      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      showCursor: false,

      selectionControls: null,
      scrollPadding: EdgeInsets.zero,
      enableIMEPersonalizedLearning: true,
      autofillHints: null,
      restorationId: null,
      cursorWidth: 2.0,
      cursorHeight: null,
      cursorRadius: null,

      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
        prefix: RichText(
          text: TextSpan(children: textSpans),
        ),
      ),
    );
  }
}


