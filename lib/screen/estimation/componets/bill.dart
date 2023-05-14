import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homco/Color.dart';
import 'package:homco/model/energycostModel.dart';
import 'package:homco/model/manpowerModel.dart';
import 'package:homco/model/packingMaterilModel.dart';
import 'package:homco/screen/estimation/componets/estimateParameter.dart';

import '../../../common/bdecoration.dart';
import '../../../common/size.dart';
import '../textstyle.dart';
import 'billComponents.dart';

import 'package:excel/excel.dart' as db;

ValueNotifier notifier = ValueNotifier(10);

class bill extends StatefulWidget {
  parameterConnector Evalue;

  bill({required this.Evalue, super.key});

  @override
  State<bill> createState() => _billState(Evalue: Evalue);
}

class _billState extends State<bill> {
  parameterConnector Evalue;
  _billState({required this.Evalue});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startlistener();
    params = billparameters(Evalue);
  }

  late billparameters params;
  startlistener() {
    Evalue.updater!.addListener(() {
      params = billparameters(Evalue);
    });
    params = billparameters(Evalue);
    notifier.addListener(() {
      setState(() {
        isloading = false;
      });
    });
  }

  bool isloading = true;
  bool applyoverheads = true;
  @override
  Widget build(BuildContext context) {
    return (isloading)
        ? Container()
        : Container(
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
                billtotalItem(
                    "Total Material Cost", "${Evalue.pmode.PriceTotal}/-",
                    top: 20),
                billItem("No. of Packs", "${params.packCount}", top: 20),
                billItem("Packing Cost/ Pack", "${params.packCost}"),
                billtotalItem(
                    "Packing Expences / Batch", "${params.packTotal}/-"),
                billtotalItem("Direct Labour Cost", "${params.LabourCost}/-",
                    top: 20),
                billtotalItem("Energy Cost / Batch", "${params.Egcost}/-",
                    top: 20),
                billtotalItem("Prime Cost / Batch", "${params.primecost}/-"),
                if (!applyoverheads)
                  billItem("Factory Overhead", "${params.factory}/-", top: 20),
                if (!applyoverheads)
                  billtotalItem(
                      "Factory overHead / Batch", "${params.Bfactory}/-"),
                if (!applyoverheads)
                  billItem(
                      "Administrative Overheads", "${params.administrative}/-",
                      top: 20),
                if (!applyoverheads)
                  billtotalItem("Cost of Production / Batch",
                      "${params.Badminstrative}/-"),
                if (!applyoverheads)
                  billItem(
                      "Selling & Distribution Overheads", "${params.sales}/-",
                      top: 20),
                if (!applyoverheads)
                  billtotalItem(
                      "Cost of Sales per Batch", "${params.bsales}/-"),
                if (!applyoverheads)
                  billtotalItem("Cost / Pack",
                      "${(params.bsales / params.packCount).roundToDouble()}/-"),
                if (applyoverheads)
                  billtotalItem("Cost / Pack",
                      "${(params.primecost / params.packCount).roundToDouble()}/-"),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 10),
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("cost/ batch without overheads"),
                      Checkbox(
                          value: applyoverheads,
                          fillColor: MaterialStatePropertyAll(appLightGreen),
                          onChanged: (onvalue) {
                            setState(() {
                              applyoverheads = onvalue!;
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class billparameters {
  int packCount = 0;
  double packCost = 0;
  double packTotal = 0;
  double packqty = 0;
  double LabourCost = 0;
  double Egcost = 0;
  double primecost = 0;
  double factory = 0;
  double Bfactory = 0;
  double administrative = 0;
  double Badminstrative = 0;
  double sales = 0;
  double bsales = 0;

  parameterConnector evalue = parameterConnector();
  billparameters(parameterConnector val) {
    evalue = val;
    loadPacking();
    print("working");
    loadLabourCost();
    loadEnergyCost();
  }

  loadPacking() async {
    var db = await Hive.openBox("PACKINGMATERIAL");
    double qty = double.parse(evalue.qtyText.text);
    double tolerance = double.parse(evalue.tolerance.text);
    String key = evalue.packText.text.trim().toUpperCase();

    packingmaterialModel pkmodel = db.get(key);
    double usefullltr = (qty - ((qty * tolerance) / 100)) * 1000;
    packCost = double.parse(pkmodel.price!);
    packCount = (usefullltr / pkmodel.quantity!).round();
    packTotal = packCost * packCount;
    packqty = pkmodel.quantity!;
    print("bill parameter");
    print(qty);
    print(usefullltr);
    print(packCost);
    print(packCount);
    print(packTotal);
    notifier.value++;
    //packCount = packCount.roundToDouble();
  }

  loadLabourCost() async {
    var db = await Hive.openBox("MANPOWERPACKING");
    print("working");
    String key = evalue.category.toUpperCase();
    List pklist = db.get(key);

    for (Packing pk in pklist) {
      if (pk.quantity == packqty) {
        LabourCost = ((packCount * pk.amount!) / 60) *
            double.parse(evalue.workcost.text);
        notifier.value++;
      }
    }
  }

  loadEnergyCost() async {
    var db = await Hive.openBox("ENERGYCOST");
    String key = evalue.category.toUpperCase();
    EnergyCostModel eg = db.get(key);
    Egcost = (eg.price! * double.parse(evalue.energycost.text));
    totalCost();
    notifier.value++;
  }

  totalCost() {
    primecost = (evalue.pmode.PriceTotal + packTotal + LabourCost + Egcost);

    factory = (primecost * (12 / 100)).roundToDouble();
    Bfactory = (primecost + factory).roundToDouble();
    administrative = (Bfactory * (8 / 100)).roundToDouble();
    Badminstrative = (Bfactory + administrative).roundToDouble();
    sales = (Badminstrative * (6 / 100)).roundToDouble();
    bsales = (Badminstrative + sales).roundToDouble();
    evalue.finalCost = (bsales / packCount).roundToDouble();
    notifier.value++;
  }
}
