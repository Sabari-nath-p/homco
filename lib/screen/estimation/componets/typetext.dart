import 'package:flutter/material.dart';

import '../../../Color.dart';

topText(String name) => Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "$name ",
            style: TextStyle(
                fontSize: 40,
                fontFamily: "Monsterrat",
                fontWeight: FontWeight.bold,
                color: appGreen),
          ),
          Text(
            "Costing Sheet",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
    );
