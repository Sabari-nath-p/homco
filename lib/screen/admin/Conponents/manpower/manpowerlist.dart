import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/Color.dart';
import 'package:homco/screen/admin/Conponents/manpower/manpoweradd.dart';
import 'package:homco/screen/admin/Conponents/manpower/manpowerview.dart';
import 'package:homco/screen/admin/Conponents/product/productAdd.dart';
import 'package:homco/screen/admin/Conponents/product/productview.dart';
import 'package:homco/screen/admin/admin.dart';

var manpowereditcheck = null;

class manpowerlist extends StatefulWidget {
  const manpowerlist({super.key});

  @override
  State<manpowerlist> createState() => _manpowerlistState();
}

class _manpowerlistState extends State<manpowerlist> {
  @override
  int optionSelector = 0;
  List option = ["VIEW ", "ADD/EDIT"];
  ValueNotifier notifier = ValueNotifier(10);

  startListerner() {
    notifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startListerner();
    manpowereditcheck = null;
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appLightGreen, width: 3),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(.8),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        for (int i = 0; i < 2; i++)
                          InkWell(
                            onTap: () {
                              setState(() {
                                optionSelector = i;
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  color: (i == optionSelector)
                                      ? Colors.yellowAccent.withOpacity(.3)
                                      : Colors.white),
                              child: Text(option[i]),
                            ),
                          )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: appGreen,
                  ),
                  if (optionSelector == 0 && manpowereditcheck == null)
                    Container(
                        width: 550,
                        height: 600,
                        child: manpowerView(
                          notifier: notifier,
                        )),
                  if (optionSelector == 1 && manpowereditcheck == null)
                    Container(
                      child: manpowerAdd(
                        notifier: notifier,
                      ),
                    ),
                  if (manpowereditcheck != null)
                    manpowerAdd(
                      notifier: notifier,
                      EditData: manpowereditcheck,
                    )
                ],
              ))
        ],
      ),
    );
  }
}
