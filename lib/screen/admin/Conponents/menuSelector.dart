import 'package:flutter/material.dart';
import 'package:homco/Color.dart';

menuSelector(String name, String option) => Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      width: 300,
      height: 60,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
          border: (name == option)
              ? Border.all(color: appLightGreen, width: 2)
              : null),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$name ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"),
            ),
          ),
          Icon(
            Icons.arrow_right,
            color: appLightGreen,
          )
        ],
      ),
    );
