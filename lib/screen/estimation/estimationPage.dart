import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homco/Color.dart';
import 'package:homco/common/bdecoration.dart';
import 'package:homco/common/size.dart';
import 'package:homco/model/packingMaterilModel.dart';
import 'package:homco/screen/estimation/DataModel/commonModel.dart';
import 'package:homco/screen/estimation/DataModel/priceModel.dart';
import 'package:homco/screen/estimation/componets/bill.dart';
import 'package:homco/screen/estimation/componets/estimateParameter.dart';
import 'package:homco/screen/estimation/componets/ingredientList.dart';
import 'package:homco/screen/estimation/componets/typetext.dart';
import 'package:homco/screen/estimation/textstyle.dart';
import 'package:excel/excel.dart' as db;

import '../../common/simpleGenerator.dart';
import '../../model/productsModel.dart';

class estimationPage extends StatefulWidget {
  String value;
  estimationPage({super.key, required this.value});

  @override
  State<estimationPage> createState() => _estimationPageState();
}

class _estimationPageState extends State<estimationPage> {
  loadData() async {
    loadProducts();
    loadPackMaterial();
    Evalue.updater = updater;
    Evalue.category = widget.value;
  }

  loadProducts() async {
    var db = await Hive.openBox("PRODUCT");
    var db2 = await Hive.openBox("PRODUCTING");

    setState(() {
      for (var ky in db.keys) {
        print(ky);
        productModel pd = db.get(ky);
        List ing = db2.get(ky);
        pd.ingredientsList = ing.cast<IngredientsList>();
        //   print(db2.get(ky));
        // print(pd.toJson());
        print(widget.value);
        print(pd.toJson());
        if (widget.value.trim().toUpperCase() ==
            pd.productCategory!.trim().toUpperCase())
          products.add(pd.productName);
      }
      Evalue.products = products;
    });
  }

  loadPackMaterial() async {
    var db = await Hive.openBox("PACKINGMATERIAL");
    setState(() {
      for (packingmaterialModel pk in db.values) {
        Evalue.packtype.add(pk.packName);
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
          Positioned(
              top: 30,
              right: 20,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Text(
                    "exit",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: appLightGreen.withOpacity(.8),
                      borderRadius: BorderRadius.circular(10)),
                ),
              )),
          Positioned(top: 30, left: 63, child: topText("${widget.value}")),
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
                      ),
                    if (Evalue.finalCost != 0)
                      Container(
                        margin: EdgeInsets.only(right: 30, top: 10),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Final Cost / Pack   : ",
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
                                          " ${Evalue.finalCost.toString()}/-"),
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
          if (Evalue.pmode.ingredient.isNotEmpty)
            Positioned(
                left: 800,
                right: 150,
                top: 100,
                bottom: 40,
                child: bill(
                  Evalue: Evalue,
                ))
        ],
      ),
    );
  }
}
