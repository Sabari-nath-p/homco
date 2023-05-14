import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homco/model/manpowerModel.dart';
import 'package:homco/model/packingMaterilModel.dart';
import 'package:homco/model/productsModel.dart';
import 'package:homco/model/rawMaterial.dart';
import 'package:homco/screen/admin/Conponents/manpower/manpowerlist.dart';
import 'package:homco/screen/admin/Conponents/product/productlist.dart';
import 'package:homco/screen/admin/common/addText.dart';
import 'package:homco/screen/estimation/textstyle.dart';
import 'package:homco/screen/splash/splashmain.dart';

import '../../../../Color.dart';

class manpowerAdd extends StatefulWidget {
  var EditData;
  ValueNotifier notifier;
  manpowerAdd({super.key, this.EditData = null, required this.notifier});

  @override
  State<manpowerAdd> createState() => _manpowerAddState();
}

TextEditingController catText = TextEditingController();
manpowerModel mnModel = manpowerModel(packing: []);

class _manpowerAddState extends State<manpowerAdd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mnModel.packing = [];
    if (widget.EditData != null) {
      mnModel = widget.EditData;
      connectData();
    }
  }

  connectData() {
    setState(() {
      catText.text = mnModel.categoryName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TypeSelectionText("Category Name ", catText, Categories),
              ),
              InkWell(
                onTap: () async {
                  if (catText.text.isNotEmpty && mnModel.packing!.isNotEmpty) {
                    mnModel.categoryName = catText.text.trim();
                    var box = await Hive.openBox("MANPOWER");
                    var db = await Hive.openBox("MANPOWERPACKING");
                    box.put(mnModel.categoryName!.toUpperCase(), mnModel);
                    print(mnModel.toJson());
                    db.put(
                        mnModel.categoryName!.toUpperCase(), mnModel.packing);
                    setState(() {
                      if (widget.EditData != null) {
                        manpowereditcheck = null;
                        widget.notifier.value++;
                      }
                      mnModel.packing = [];
                      mnModel = manpowerModel();
                      mnModel.packing = [];
                      catText.text = "";
                    });
                  }
                  //  var box = await Hive.openBox("PRODUCT");
                  //   box.deleteFromDisk();
                  //   var db = await Hive.openBox("PRODUCTING");
                  //   db.deleteFromDisk();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appGreen.withOpacity(.6),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    (widget.EditData == null) ? "Add Product" : "Save Edit",
                    style: tbox(),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "   Add Quantity",
                style: tbox(),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  addIngredient();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appGreen.withOpacity(.6),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "Add Quantity",
                    style: tbox(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            width: 500,
            height: 250,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                Container(
                  width: 500,
                  height: 230,
                  margin: EdgeInsets.only(top: 10),
                  child: DataTable2(
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      dataTextStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: "Poppins"),
                      columns: [
                        DataColumn2(
                          label: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            width: double.infinity,
                            height: 30,
                            padding: EdgeInsets.only(left: 4),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          size: ColumnSize.M,
                          fixedWidth: 100,
                        ),
                        DataColumn2(
                          label: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            width: double.infinity,
                            height: 30,
                            padding: EdgeInsets.only(left: 4),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'unit',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          size: ColumnSize.M,
                          fixedWidth: 90,
                        ),
                        DataColumn2(
                            label: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black))),
                                width: double.infinity,
                                height: 30,
                                padding: EdgeInsets.only(left: 4, right: 4),
                                alignment: Alignment.topCenter,
                                child: Text('Amount')),
                            size: ColumnSize.M,
                            fixedWidth: 100),
                        DataColumn2(
                            label: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black))),
                                width: double.infinity,
                                height: 30,
                                padding: EdgeInsets.only(left: 4, right: 4),
                                alignment: Alignment.topCenter,
                                child: Text('Remove')),
                            size: ColumnSize.M,
                            fixedWidth: 90),
                      ],
                      rows: [
                        for (Packing ing in mnModel.packing!) addRow(ing)
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  addIngredient() async {
    var db = await Hive.openBox("PACKINGMATERIAL");
    TextEditingController amount = TextEditingController();
    TextEditingController qtyText = TextEditingController();
    TextEditingController unitText = TextEditingController();
    List avlqty = [];
    for (packingmaterialModel nms in db.values) {
      avlqty.add(nms.quantity.toString());
    }
    showDialog(
        context: context,
        builder: (context) => Material(
              color: Colors.transparent,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 500, vertical: 180),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Add Ingredient ",
                          style: tbox(),
                        ),
                        TypeSelectionText("Quantity ", qtyText, avlqty,
                            width: 90),
                        TypeText("Manpower Cost", amount, width: 90),
                        TypeText("Unit of pack", unitText, width: 90),
                        InkWell(
                          onTap: () {
                            if (qtyText.text.isNotEmpty &&
                                amount.text.isNotEmpty &&
                                unitText.text.isNotEmpty) {
                              Packing ing = Packing(
                                  unit: unitText.text.trim(),
                                  quantity:
                                      double.parse(qtyText.text.toString()),
                                  amount: double.parse(amount.text.trim()));
                              setState(() {
                                mnModel.packing!.add(ing);
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.yellow.withOpacity(.54)),
                            child: Text(
                              "ADD",
                              style: tbox(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  addRow(Packing packing) {
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(packing.quantity.toString()))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(packing.unit.toString()))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(packing.amount.toString()))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  mnModel.packing!.remove(packing);
                });
              },
              child: Text(
                "-",
                style: tbox(color: Colors.redAccent),
              ),
            ))),
      ],
    );
  }
}
