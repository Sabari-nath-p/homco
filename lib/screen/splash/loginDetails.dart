import 'package:flutter/material.dart';

loginDetails() => Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue, width: 1.8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "H O M C O",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.black54),
          ),
          SizedBox(
            width: 320,
            child: Text(
              "THE KERALA STATE HOMOEOPATHIC CO-OPERATIVE PHARMACY LTD",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54),
            ),
          ),
          Text(
            "Admin Login",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black54),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue, width: 1.5)),
            width: 320,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "User Id"),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue, width: 1.5)),
            width: 320,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Password"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
            width: 180,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(24)),
            child: Text(
              "Submit",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
