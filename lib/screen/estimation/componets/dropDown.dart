import 'package:flutter/material.dart';
import 'package:homco/screen/estimation/textstyle.dart';
import 'package:searchfield/searchfield.dart';

Widget dropDown(TextEditingController productSearch, List products) =>
    SearchField(
      controller: productSearch,
      suggestions: products
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
      searchStyle: tbox(FontWeight: FontWeight.w400),
      searchInputDecoration: InputDecoration(border: InputBorder.none),
      onSubmit: (p0) {
        for (String prd in products) {
          if (prd.toUpperCase().contains(p0.toUpperCase())) {
            productSearch.text = prd;
            break;
          } else {
            productSearch.text = "";
          }
        }
      },
    );
