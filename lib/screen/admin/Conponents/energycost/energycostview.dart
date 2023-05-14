import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homco/model/energycostModel.dart';

import 'package:homco/model/productsModel.dart';
import 'package:homco/model/rawMaterial.dart';
import 'package:homco/screen/admin/Conponents/RawMaterial/rawmateriallist.dart';
import 'package:homco/screen/admin/Conponents/RawMaterial/rawmateriladd.dart';
import 'package:homco/screen/admin/Conponents/energycost/energycostlist.dart';
import 'package:homco/screen/estimation/DataModel/commonModel.dart';

class energycostview extends StatefulWidget {
  ValueNotifier notifier;
  energycostview({super.key, required this.notifier});

  @override
  State<energycostview> createState() => _energycostviewState();
}

class _energycostviewState extends State<energycostview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadList();
  }

  List energy = [];
  loadList() async {
    var box = await Hive.openBox("ENERGYCOST");
    setState(() {
      for (var nm in box.keys) {
        energy.add(box.get(nm));
        print(box.get(nm));
        print(nm);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 480,
      margin: EdgeInsets.only(top: 10, left: 20),
      alignment: Alignment.topLeft,
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
                    child: Text("ID")),
                size: ColumnSize.S,
                fixedWidth: 100),
            DataColumn2(
                label: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.only(left: 4),
                  alignment: Alignment.center,
                  color: Colors.yellow.withOpacity(.5),
                  child: Text(
                    'Content Name ',
                  ),
                ),
                size: ColumnSize.M,
                fixedWidth: 150),
            DataColumn2(
                label: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 4, right: 4),
                    alignment: Alignment.center,
                    color: Colors.yellow.withOpacity(.5),
                    child: Text('Price')),
                size: ColumnSize.M,
                fixedWidth: 90),
            DataColumn2(
                label: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 4, right: 4),
                    alignment: Alignment.center,
                    color: Colors.yellow.withOpacity(.5),
                    child: Text('Action')),
                size: ColumnSize.M,
                fixedWidth: 100),
          ],
          rows: [
            for (int i = 1; i <= energy.length; i++)
              addRow(energy[i - 1], index: i)
          ]),
    );
  }

  addRow(EnergyCostModel pd, {int index = 0}) {
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(index.toString()))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pd.categoryName!))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pd.price.toString()))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      energycostEditCheck = pd;
                      widget.notifier.value++;
                    },
                    child: Icon(Icons.edit)),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.delete)
              ],
            ))),
      ],
    );
  }
}
