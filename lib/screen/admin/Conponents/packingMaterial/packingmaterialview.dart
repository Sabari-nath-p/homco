import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/common/size.dart';
import 'package:homco/model/packingMaterilModel.dart';
import 'package:homco/screen/admin/Conponents/packingMaterial/packingmateriallist.dart';

import '../../../../model/productsModel.dart';

class packingmaterialView extends StatefulWidget {
  ValueNotifier notifier;
  packingmaterialView({super.key, required this.notifier});

  @override
  State<packingmaterialView> createState() => _packingmaterialViewState();
}

class _packingmaterialViewState extends State<packingmaterialView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadpacking();
    delete();
  }

  delete() async {
    //Hive.deleteBoxFromDisk("ENERGYCOST");
  }

  List PackList = [];
  loadpacking() async {
    var db = await Hive.openBox("PACKINGMATERIAL");
    setState(() {
      for (packingmaterialModel pkModel in db.values) {
        PackList.add(pkModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 657,
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
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(left: 4),
                    alignment: Alignment.center,
                    color: Colors.yellow.withOpacity(.5),
                    child: Text("Name")),
                size: ColumnSize.S,
                fixedWidth: 200),
            DataColumn2(
                label: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.only(left: 4),
                  alignment: Alignment.center,
                  color: Colors.yellow.withOpacity(.5),
                  child: Text(
                    'Quantity',
                  ),
                ),
                size: ColumnSize.M,
                fixedWidth: 100),
            DataColumn2(
              label: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(left: 4),
                alignment: Alignment.center,
                color: Colors.yellow.withOpacity(.5),
                child: Text(
                  'Unit',
                  textAlign: TextAlign.center,
                ),
              ),
              size: ColumnSize.M,
              fixedWidth: 100,
            ),
            DataColumn2(
              label: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(left: 4),
                alignment: Alignment.center,
                color: Colors.yellow.withOpacity(.5),
                child: Text(
                  'price',
                  textAlign: TextAlign.center,
                ),
              ),
              size: ColumnSize.M,
              fixedWidth: 100,
            ),
            DataColumn2(
              label: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(left: 4),
                alignment: Alignment.center,
                color: Colors.yellow.withOpacity(.5),
                child: Text(
                  'Actions',
                  textAlign: TextAlign.center,
                ),
              ),
              size: ColumnSize.M,
              fixedWidth: 100,
            ),
          ],
          rows: [
            for (packingmaterialModel pkmodel in PackList) addRow(pkmodel)
          ]),
    );
  }

  addRow(packingmaterialModel pk) {
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pk.packName!))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pk.quantity.toString()))),
        DataCell(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pk.unit.toString()))),
        DataCell(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pk.price.toString()))),
        DataCell(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      packEditCheck = pk;
                      widget.notifier.value++;
                    },
                    child: Icon(Icons.edit)),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () async {
                      var db = await Hive.openBox("PACKINGMATERIAL");
                      db.delete(pk.packName!.toUpperCase());
                      db.close();
                      setState(() {
                        PackList.clear();
                        loadpacking();
                      });
                    },
                    child: Icon(Icons.delete))
              ],
            ))),
      ],
    );
  }
}
