import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/Color.dart';
import 'package:homco/screen/admin/Conponents/product/productAdd.dart';
import 'package:homco/screen/admin/Conponents/product/productview.dart';
import 'package:homco/screen/admin/admin.dart';

var productEditCheck = null;

class productlist extends StatefulWidget {
  const productlist({super.key});

  @override
  State<productlist> createState() => _productlistState();
}

class _productlistState extends State<productlist> {
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
                  if (optionSelector == 0 && productEditCheck == null)
                    Container(
                        width: 750,
                        height: 600,
                        child: productview(
                          notifier: notifier,
                        )),
                  if (optionSelector == 1 && productEditCheck == null)
                    Container(
                      child: productAdd(
                        notifier: notifier,
                      ),
                    ),
                  if (productEditCheck != null)
                    productAdd(
                      notifier: notifier,
                      EditData: productEditCheck,
                    )
                ],
              ))
        ],
      ),
    );
  }
}
