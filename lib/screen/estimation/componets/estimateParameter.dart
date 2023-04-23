import 'package:flutter/material.dart';
import 'package:homco/screen/estimation/DataModel/commonModel.dart';
import 'package:homco/screen/estimation/DataModel/priceModel.dart';
import 'package:homco/screen/estimation/estimationPage.dart';
import 'package:excel/excel.dart' as db;

import '../../../Color.dart';
import '../../../common/bdecoration.dart';
import '../../../common/size.dart';
import '../textstyle.dart';
import 'dropDown.dart';

estimateparater(parameterConnector parameter) => Column(
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
              height: 35,
              width: 250,
              decoration: tboxdecoration(),
              child: Row(children: [
                width(10),
                Expanded(
                    child: dropDown(parameter.productText, parameter.products)),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 35,
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
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: tboxdecoration(),
                child: TextField(
                    controller: parameter.qtyText,
                    textAlign: TextAlign.end,
                    style: tbox(),
                    decoration: InputDecoration(
                        isDense: true,
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
              height: 35,
              width: 220,
              decoration: tboxdecoration(),
              child: Row(children: [
                width(10),
                Expanded(
                    child: dropDown(parameter.packText, parameter.packtype)),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 35,
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
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: tboxdecoration(),
                child: TextField(
                    controller: parameter.tolerance,
                    textAlign: TextAlign.end,
                    style: tbox(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
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
                width: 90,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: tboxdecoration(),
                child: TextField(
                    controller: parameter.workcost,
                    textAlign: TextAlign.center,
                    style: tbox(),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ))),
            width(20),
            Text(
              "Energy/hr  :",
              style: tbox(color: appGreen),
            ),
            width(20),
            Container(
                width: 90,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: tboxdecoration(),
                child: TextField(
                    controller: parameter.energycost,
                    textAlign: TextAlign.center,
                    style: tbox(),
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      border: InputBorder.none,
                    ))),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                int index =
                    parameter.products.indexOf(parameter.productText.text) + 4;

                parameter.pmode.ingredient.clear();
                parameter.pmode.ingredientQty.clear();
                parameter.pmode.ingredientPrice.clear();
                parameter.pmode.ingredientSub.clear();
                var Sheet = parameter.excel!["Ingredient List - Mother Tinctu"];
                var cell = Sheet.cell(db.CellIndex.indexByString("E${index}"));

                parameter.pmode.ingredient.add(cell.value.toString());
                cell = Sheet.cell(db.CellIndex.indexByString("F${index}"));
                parameter.pmode.ingredient.add(cell.value.toString());
                cell = Sheet.cell(db.CellIndex.indexByString("G${index}"));
                parameter.pmode.ingredient.add(cell.value.toString());

                cell = Sheet.cell(db.CellIndex.indexByString("K${index}"));

                double qty = double.parse(cell.value.toString());

                parameter.pmode.ingredientQty.add(qty);
                cell = Sheet.cell(db.CellIndex.indexByString("L${index}"));
                qty = double.parse(cell.value.toString());

                parameter.pmode.ingredientQty.add(qty);
                cell = Sheet.cell(db.CellIndex.indexByString("M${index}"));
                qty = double.parse(cell.value.toString());

                parameter.pmode.ingredientQty.add(qty);

                for (var ing in parameter.pmode.ingredient) {
                  for (ingredientModel price in parameter.itemPrice) {
                    if (price.Name.contains(ing)) {
                      parameter.pmode.ingredientPrice.add(price.Price);
                    }
                  }
                }
                double? tempTotal = 0;
                int i = 0;
                for (var ing in parameter.pmode.ingredientPrice) {
                  double tempQty = parameter.pmode.ingredientQty[i] *
                      double.parse(parameter.qtyText.text.toString())
                          .toDouble();
                  print(tempQty);
                  tempTotal = tempTotal! + (tempQty * ing) as double;
                  parameter.pmode.ingredientSub.add(tempQty * ing);
                  i++;
                }
                parameter.pmode.PriceTotal = tempTotal!;
                parameter.updater?.value++;
              },
              child: Container(
                decoration: buttonDecoration(),
                padding: EdgeInsets.all(10),
                child: Text(
                  "Estimate",
                  style: tbox(color: Colors.white),
                ),
              ),
            )
          ],
        )
      ],
    );

class parameterConnector {
  List products = [];
  List packtype = [];
  List itemPrice = [];
  TextEditingController productText = TextEditingController();
  TextEditingController qtyText = TextEditingController();
  TextEditingController packText = TextEditingController();
  TextEditingController tolerance = TextEditingController();
  TextEditingController workcost = TextEditingController();
  TextEditingController energycost = TextEditingController();
  priceModel pmode = priceModel();
  ValueNotifier? updater;
  db.Excel? excel;
}
