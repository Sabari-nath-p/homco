import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/model/productsModel.dart';
import 'package:homco/screen/admin/Conponents/product/productlist.dart';
import 'package:homco/screen/estimation/DataModel/commonModel.dart';
import 'package:homco/screen/estimation/componets/ingredientList.dart';
import '../../../../Color.dart';

class productview extends StatefulWidget {
  ValueNotifier notifier;
  productview({super.key, required this.notifier});

  @override
  State<productview> createState() => _productviewState();
}

class _productviewState extends State<productview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadproduct();
    //delete();
  }

  List products = [];

  TextEditingController searchController = TextEditingController();
  delete() async {
    Hive.deleteBoxFromDisk("PRODUCT");
    Hive.deleteBoxFromDisk("PRODUCTING");
  }

  loadproduct() async {
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
        products.add(pd);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                          child: Text("Content")),
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
                        'Ingredients',
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
                          child: Text('Quantity (%)')),
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
                  for (productModel pd in products) addRow(pd)
                ]),
          ),
          /*  SizedBox(
            width: 50,
          ),
          Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.yellow.withOpacity(.4)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  print(value);
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Search product"),
            ),
          )*/
        ],
      ),
    );
  }

  addRow(productModel pd) {
    print(pd.ingredientsList);
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pd.productName!))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(pd.productCategory!))),
        DataCell(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (IngredientsList v in pd.ingredientsList!) Text(v.content!)
              ],
            ))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (IngredientsList v in pd.ingredientsList!)
                  Text(v.quantity.toString())
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
                      productEditCheck = pd;
                      widget.notifier.value++;
                    },
                    child: Icon(Icons.edit)),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () async {
                      var db = await Hive.openBox("PRODUCT");
                      var db2 = await Hive.openBox("PRODUCTING");
                      db.delete(pd.productName!.toUpperCase());
                      db2.delete(pd.productName!.toUpperCase());
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
