import 'package:flutter/material.dart';
import 'package:homco/Color.dart';
import 'package:homco/screen/admin/admin.dart';

loginDetails(BuildContext context) => InkWell(
      onTap: () {
        // Navigator.of(context)
        //  .push(MaterialPageRoute(builder: (context) => adminScreen()));
      },
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Admin Login",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54),
            ),
            Container(
              width: 320,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration:
                    InputDecoration(hintText: "User Id", labelText: "User ID"),
              ),
            ),
            Container(
              width: 320,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Password", labelText: "Password"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => adminScreen()));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                //margin: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                margin: EdgeInsets.only(left: 10, top: 10),
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: appLightGreen.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
