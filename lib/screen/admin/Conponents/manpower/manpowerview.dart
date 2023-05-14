import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/model/manpowerModel.dart';
import 'package:homco/model/productsModel.dart';
import 'package:homco/screen/admin/Conponents/manpower/manpowerlist.dart';
import 'package:homco/screen/admin/Conponents/product/productlist.dart';
import 'package:homco/screen/estimation/DataModel/commonModel.dart';
import 'package:homco/screen/estimation/componets/ingredientList.dart';
import '../../../../Color.dart';

class manpowerView extends StatefulWidget {
  ValueNotifier notifier;
  manpowerView({super.key, required this.notifier});

  @override
  State<manpowerView> createState() => _manpowerViewState();
}

class _manpowerViewState extends State<manpowerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadproduct();
    // delete();
  }

  delete() async {
    Hive.deleteBoxFromDisk("MANPOWER");
    Hive.deleteBoxFromDisk("MANPOWERPACKING");
  }

  List products = [];
  loadproduct() async {
    var db = await Hive.openBox("MANPOWER");
    var db2 = await Hive.openBox("MANPOWERPACKING");
    setState(() {
      for (var ky in db.keys) {
        print(ky);
        manpowerModel pd = db.get(ky);
        List ing = db2.get(ky);
        pd.packing = ing.cast<Packing>();
        //   print(db2.get(ky));
        // print(pd.toJson());
        products.add(pd);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      margin: EdgeInsets.only(top: 10),
      child: DataTable2(
          columnSpacing: 0,
          horizontalMargin: 0,
          dataRowHeight: 90,
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
                  child: Text(
                    'Category',
                  ),
                ),
                size: ColumnSize.M,
                fixedWidth: 150),
            DataColumn2(
              label: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(left: 4),
                alignment: Alignment.center,
                color: Colors.yellow.withOpacity(.5),
                child: Text(
                  'Packings',
                  textAlign: TextAlign.center,
                ),
              ),
              size: ColumnSize.M,
              fixedWidth: 200,
            ),
            DataColumn2(
                label: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 4, right: 4),
                    alignment: Alignment.center,
                    color: Colors.yellow.withOpacity(.5),
                    child: Text('Price / Pack')),
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
                fixedWidth: 90),
          ],
          rows: [
            for (manpowerModel pd in products) addRow(pd)
          ]),
    );
  }

  addRow(manpowerModel pd) {
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pd.categoryName!))),
        DataCell(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (Packing v in pd.packing!)
                  Text("${v.quantity.toString()} ${v.unit.toString()}")
              ],
            ))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (Packing v in pd.packing!) Text(v.amount.toString())
              ],
            ))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      manpowereditcheck = pd;
                      widget.notifier.value++;
                    },
                    child: Icon(Icons.edit)),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () async {
                      var db = await Hive.openBox("MANPOWER");
                      var db2 = await Hive.openBox("MANPOWERPACKING");
                      db.delete(pd.categoryName!.toUpperCase());
                      db2.delete(pd.categoryName!.toUpperCase());
                      setState(() {
                        products.clear();
                        loadproduct();
                      });
                    },
                    child: Icon(Icons.delete))
              ],
            ))),
      ],
    );
  }
}
