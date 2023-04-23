import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/Color.dart';
import 'package:homco/common/bdecoration.dart';
import 'package:homco/common/size.dart';
import 'package:homco/screen/estimation/DataModel/commonModel.dart';
import 'package:homco/screen/estimation/DataModel/priceModel.dart';
import 'package:homco/screen/estimation/componets/billComponents.dart';
import 'package:homco/screen/estimation/componets/estimateParameter.dart';
import 'package:homco/screen/estimation/componets/ingredientList.dart';
import 'package:homco/screen/estimation/componets/typetext.dart';
import 'package:searchfield/searchfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:homco/screen/estimation/textstyle.dart';
import 'package:excel/excel.dart' as db;

import '../../common/simpleGenerator.dart';
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

    db.Excel excel = db.Excel.decodeBytes(bytes);
    Evalue.excel = excel;
    db.Sheet sheetObject = excel['Ingredient List - Mother Tinctu'];
    db.Sheet packingMaterial = excel['Packing Material - Cost'];
    db.Sheet ingredient = excel['RM Price list'];
    setState(() {
      for (int i = 4; i < 1167; i++) {
        var cell = sheetObject.cell(db.CellIndex.indexByString("C$i"));
        if (i < 10) {
          var pcell =
              packingMaterial.cell(db.CellIndex.indexByString("A${i - 1}"));
          Evalue.packtype.add(pcell.value.toString());
        }

        if (i < 318) {
          //ingredeint name
          var ingName = ingredient.cell(db.CellIndex.indexByString("B$i"));
          //ingredeint price
          var ingPrice = ingredient.cell(db.CellIndex.indexByString("C$i"));

          ingredientModel ingModel = new ingredientModel();
          try {
            if (ingPrice.value.toString() != "" ||
                ingPrice.value.toString() != "nil" ||
                ingPrice.value.toString().length > 10) {
              ingModel.Name = ingName.value.toString();
              ingModel.Price = int.parse(ingPrice.value.toString()).toInt();
              Evalue.itemPrice.add(ingModel);
            }
          } catch (e) {
            print(e);
          }
        }
        if (cell.value.toString() == "Mother Tincture") {
          var prdName = sheetObject.cell(db.CellIndex.indexByString("D$i"));

          Evalue.products.add(prdName.value.toString());
        }
      }
    });
  }

  List products = [];
  List IngredientpriceList = [];
  priceModel pModel = priceModel();
  ValueNotifier updater = ValueNotifier(10);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    Evalue.pmode = pModel;
    Evalue.updater = updater;
    startLister();
  }

  startLister() {
    updater.addListener(() {
      setState(() {});
    });
  }

  parameterConnector Evalue = parameterConnector();

  TextEditingController prodcuctSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6EDC5),
      body: Stack(
        children: [
          Positioned(top: 30, left: 63, child: topText("MOTHERTINCHER")),
          Positioned(
              top: 100,
              left: 60,
              right: 750,
              bottom: 40,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.66),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: appLightGreen, width: 4)),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(30),
                        child: estimateparater(Evalue)),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: appLightGreen,
                    ),
                    height(15),
                    Text(
                      "   Ingredients",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                    if (Evalue.pmode.ingredient.isNotEmpty)
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          alignment: Alignment.center,
                          height: 250,
                          child: ingredientList(
                            parameter: Evalue,
                          )),
                    if (Evalue.pmode.ingredient.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(right: 30, top: 20),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total Material Cost   : ",
                                style: tbox(),
                              ),
                              Container(
                                  width: 120,
                                  height: 40,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: tboxdecoration(),
                                  child: TextField(
                                      controller: TextcontrollerGenerator(
                                          " ${Evalue.pmode.PriceTotal.toString()}/-"),
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      style: tbox(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                      )))
                            ]),
                      )
                  ],
                ),
              )),
          Positioned(
              left: 800,
              right: 150,
              top: 100,
              bottom: 40,
              child: Container(
                decoration: tboxdecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(15),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "THE KERALA STATE HOMOEOPATHIC \nCO-OPERATIVE PHARMACY LTD.",
                        textAlign: TextAlign.center,
                        style: tbox(FontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Costing Sheet ${Evalue.productText.text}",
                        textAlign: TextAlign.center,
                        style: tbox(),
                      ),
                    ),
                    billtotalItem("Total Material Cost", "12300/-", top: 20),
                    billItem("No. of Packs", "2300/-", top: 20),
                    billItem("Packing Cost/ Pack", "2.4/-"),
                    billtotalItem("Packing Expences / Batch", "5300/-"),
                    billtotalItem("Direct Labour Cost", "23400/-", top: 20),
                    billtotalItem("Energy Cost / Batch", "5300/-", top: 20),
                    billtotalItem("Prime Cost / Batch", "24500/-"),
                    billItem("Factory Overhead", "2340/-", top: 20),
                    billtotalItem("Factory overHead / Batch", "24500/-"),
                    billItem("Administrative Overheads", "2340/-", top: 20),
                    billtotalItem("Cost of Production / Batch", "24500/-"),
                    billItem("Selling & Distribution Overheads", "2340/-",
                        top: 20),
                    billtotalItem("Cost of Sales per Batch", "24500/-"),
                    billtotalItem("Cost / Pack", "8/-"),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
