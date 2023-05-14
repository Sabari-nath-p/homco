import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/common/size.dart';
import 'package:homco/screen/admin/Conponents/energycost/energycostlist.dart';
import 'package:homco/screen/admin/Conponents/manpower/manpowerlist.dart';
import 'package:homco/screen/admin/Conponents/menuSelector.dart';
import 'package:homco/screen/admin/Conponents/packingMaterial/packingmateriallist.dart';
import 'package:homco/screen/admin/Conponents/product/productlist.dart';
import 'package:homco/screen/admin/Conponents/RawMaterial/rawmateriallist.dart';
import 'package:homco/screen/admin/Conponents/RawMaterial/rawmaterialview.dart';

import '../../Color.dart';

class adminScreen extends StatefulWidget {
  const adminScreen({super.key});

  @override
  State<adminScreen> createState() => _adminScreenState();
}

List Option = [
  "Products",
  "Packing Material",
  "Raw Material",
  "Man Power",
  "Energy Cost"
];
int OptionSelector = 0;

class _adminScreenState extends State<adminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appYellow,
      body: Container(
        child: Stack(
          children: [
            Positioned(
                top: 20,
                right: 12,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: appLightGreen.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )),
            Positioned(
                top: 50,
                bottom: 20,
                left: 10,
                child: Container(
                  width: 350,
                  color: Colors.white,
                  child: Column(
                    children: [
                      height(20),
                      for (int i = 0; i < 5; i++)
                        InkWell(
                            onTap: () {
                              setState(() {
                                OptionSelector = i;
                              });
                            },
                            child:
                                menuSelector(Option[i], Option[OptionSelector]))
                    ],
                  ),
                )),
            if (OptionSelector == 0)
              Positioned(
                  left: 400,
                  top: 50,
                  right: 100,
                  bottom: 50,
                  child: productlist()),
            if (OptionSelector == 2)
              Positioned(
                  left: 400,
                  top: 50,
                  right: 100,
                  bottom: 50,
                  child: rawmateriallist()),
            if (OptionSelector == 1)
              Positioned(
                  left: 400,
                  top: 50,
                  right: 100,
                  bottom: 50,
                  child: packingmateriallist()),
            if (OptionSelector == 3)
              Positioned(
                  left: 400,
                  top: 50,
                  right: 100,
                  bottom: 50,
                  child: manpowerlist()),
            if (OptionSelector == 4)
              Positioned(
                  left: 400,
                  top: 50,
                  right: 100,
                  bottom: 50,
                  child: energycostlist()),
          ],
        ),
      ),
    );
  }
}
