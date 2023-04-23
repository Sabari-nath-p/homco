import 'package:flutter/cupertino.dart';
import 'package:homco/Color.dart';

import '../../../common/size.dart';
import '../textstyle.dart';

billItem(String title, String Value, {double top = 5}) => Container(
      margin: EdgeInsets.only(top: top),
      child: Row(
        children: [
          width(30),
          Expanded(
              child: Text(
            title,
            style: tbox(FontWeight: FontWeight.w500),
          )),
          Text(
            Value,
            style: tbox(FontWeight: FontWeight.w500),
          ),
          width(30)
        ],
      ),
    );

billtotalItem(String title, String Value, {double top = 5}) => Container(
      margin: EdgeInsets.only(top: top, left: 20, right: 20),
      color: appLightGreen.withOpacity(.09),
      child: Row(
        children: [
          width(10),
          Expanded(
              child: Text(
            title,
            style: tbox(),
          )),
          Text(
            Value,
            style: tbox(),
          ),
          width(10),
        ],
      ),
    );

billItemTitle(String title, {BoxDecoration? boxDecoration}) => Container(
      decoration: (boxDecoration != null) ? boxDecoration : null,
      margin: EdgeInsets.only(left: 30, top: 20),
      child: Text(
        title,
        style: tbox(),
      ),
    );
