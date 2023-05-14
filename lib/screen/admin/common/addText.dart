import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../estimation/textstyle.dart';

TypeText(String title, TextEditingController controller, {double width = 300}) {
  return Row(children: [
    SizedBox(
      width: 10,
    ),
    SizedBox(
      width: 200,
      child: Text(
        "$title",
        style: tbox(),
      ),
    ),
    Text(
      ":",
      style: tbox(),
    ),
    SizedBox(
      width: 30,
    ),
    Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow.withOpacity(.3)),
        width: width,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: "Enter $title"),
        ))
  ]);
}

TypeSelectionText(
    String title, TextEditingController controller, List suggestionList,
    {double width = 300}) {
  return Row(children: [
    SizedBox(
      width: 10,
    ),
    SizedBox(
      width: 200,
      child: Text(
        "$title",
        style: tbox(),
      ),
    ),
    Text(
      ":",
      style: tbox(),
    ),
    SizedBox(
      width: 30,
    ),
    Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow.withOpacity(.3)),
        width: width,
        child: SearchField(
          controller: controller,
          suggestions: suggestionList
              .map(
                (e) => SearchFieldListItem(
                  e,
                  item: e,
                  // Use child to show Custom Widgets in the suggestions
                  // defaults to Text widget

                  child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(e)),
                ),
              )
              .toList(),
          searchInputDecoration: InputDecoration(
              border: InputBorder.none, hintText: "Enter $title"),
        ))
  ]);
}
