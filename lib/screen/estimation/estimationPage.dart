import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/Color.dart';
import 'package:homco/common/bdecoration.dart';
import 'package:homco/common/size.dart';
import 'package:searchfield/searchfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:homco/screen/estimation/textstyle.dart';
import 'package:excel/excel.dart' as db;

import 'componets/dropDown.dart';

class estimationPage extends StatefulWidget {
  const estimationPage({super.key});

  @override
  State<estimationPage> createState() => _estimationPageState();
}

class _estimationPageState extends State<estimationPage> {
  loadData() async {
    ByteData data = await rootBundle.load('assets/complete file.xlsm');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    var excel = db.Excel.decodeBytes(bytes);
    db.Sheet sheetObject = excel['Ingredient List - Mother Tinctu'];
    setState(() {
      for (int i = 4; i < sheetObject.maxRows; i++) {
        var cell = sheetObject.cell(db.CellIndex.indexByString("C$i"));
        if (cell.value.toString() == "Mother Tincture") {
          var prdName = sheetObject.cell(db.CellIndex.indexByString("D$i"));

          products.add(prdName.value.toString());
        }
      }
    });
  }

  List products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  TextEditingController prodcuctSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6EDC5),
      body: Stack(
        children: [
          Positioned(
              top: 80,
              left: 60,
              right: 340,
              bottom: 40,
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.66),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: appLightGreen, width: 4)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Product Name   :",
                          style: tbox(color: appGreen),
                        ),
                        width(20),
                        Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 250,
                          decoration: tboxdecoration(),
                          child: Row(children: [
                            width(10),
                            Expanded(child: dropDown(prodcuctSearch, products)),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 40,
                              color: appGreen,
                            ),
                            width(4),
                          ]),
                        ),
                        width(20),
                        Text(
                          "Batch Size   :",
                          style: tbox(color: appGreen),
                        ),
                        width(20),
                        Container(
                            width: 80,
                            height: 60,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: tboxdecoration(),
                            child: TextField(
                                textAlign: TextAlign.end,
                                style: tbox(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffix: Text("Ltr"))))
                      ],
                    ),
                    height(10),
                    Row(
                      children: [
                        Text(
                          "Pack Type           :",
                          style: tbox(color: appGreen),
                        ),
                        width(20),
                        Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 180,
                          decoration: tboxdecoration(),
                          child: Row(children: [
                            width(10),
                            Expanded(child: dropDown(prodcuctSearch, products)),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 40,
                              color: appGreen,
                            ),
                            width(4),
                          ]),
                        ),
                        width(20),
                        Text(
                          "Tolerance     :",
                          style: tbox(color: appGreen),
                        ),
                        width(20),
                        Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: tboxdecoration(),
                            child: TextField(
                                textAlign: TextAlign.end,
                                style: tbox(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffix: Text("%"))))
                      ],
                    ),
                    height(10),
                    Row(
                      children: [
                        Text(
                          "C.Labour/hr        :",
                          style: tbox(color: appGreen),
                        ),
                        width(20),
                        Container(
                            width: 130,
                            height: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: tboxdecoration(),
                            child: TextField(
                                textAlign: TextAlign.end,
                                style: tbox(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffix: Text("%"))))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
