import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homco/model/productsModel.dart';
import 'package:homco/model/rawMaterial.dart';
import 'package:homco/screen/admin/Conponents/product/productlist.dart';
import 'package:homco/screen/admin/common/addText.dart';
import 'package:homco/screen/estimation/textstyle.dart';
import 'package:homco/screen/splash/splashmain.dart';

import '../../../../Color.dart';

class productAdd extends StatefulWidget {
  var EditData;
  ValueNotifier notifier;
  productAdd({super.key, this.EditData = null, required this.notifier});

  @override
  State<productAdd> createState() => _productAddState();
}

TextEditingController nameText = TextEditingController();
TextEditingController catText = TextEditingController();
productModel pdmodel = productModel(ingredientsList: []);

class _productAddState extends State<productAdd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pdmodel.ingredientsList = [];
    if (widget.EditData != null) {
      pdmodel = widget.EditData;
      connectData();
    }
  }

  connectData() {
    setState(() {
      nameText.text = pdmodel.productName!;

      catText.text = pdmodel.productCategory!;
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
                child: TypeText("Content Name ", nameText),
              ),
              InkWell(
                onTap: () async {
                  if (nameText.text.isNotEmpty &&
                      catText.text.isNotEmpty &&
                      pdmodel.ingredientsList!.isNotEmpty) {
                    pdmodel.productName = nameText.text.trim();
                    pdmodel.productCategory = catText.text.trim();
                    var box = await Hive.openBox("PRODUCT");
                    var db = await Hive.openBox("PRODUCTING");
                    box.put(pdmodel.productName!.toUpperCase(), pdmodel);
                    print(pdmodel.toJson());
                    db.put(pdmodel.productName!.toUpperCase(),
                        pdmodel.ingredientsList);
                    setState(() {
                      if (widget.EditData != null) {
                        productEditCheck = null;
                        widget.notifier.value++;
                      }
                      pdmodel.ingredientsList = [];
                      pdmodel = productModel();
                      pdmodel.ingredientsList = [];
                      nameText.text = "";
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
          TypeSelectionText("Content Catergory", catText, Categories,
              width: 200),
          Row(
            children: [
              Text(
                "   Add Ingredients",
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
                    "Add Ingredient",
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
                              'Ingredients',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          size: ColumnSize.M,
                          fixedWidth: 200,
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
                                child: Text('Quantity (%)')),
                            size: ColumnSize.M,
                            fixedWidth: 90),
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
                        for (IngredientsList ing in pdmodel.ingredientsList!)
                          addRow(ing)
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
    var db = await Hive.openBox("RAWMATERIAL");
    TextEditingController contenttext = TextEditingController();
    TextEditingController priceText = TextEditingController();
    List rawname = [];
    for (RawMaterialModel nms in db.values) {
      rawname.add(nms.materialName);
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
                  padding: EdgeInsets.symmetric(horizontal: 500, vertical: 230),
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
                        TypeSelectionText("Content Name ", contenttext, rawname,
                            width: 200),
                        TypeText("Quantity ( in % )", priceText, width: 150),
                        InkWell(
                          onTap: () {
                            if (contenttext.text.isNotEmpty &&
                                priceText.text.isNotEmpty) {
                              IngredientsList ing = IngredientsList(
                                  content: contenttext.text.trim(),
                                  quantity: double.parse(priceText.text.trim())
                                      .toDouble());
                              setState(() {
                                pdmodel.ingredientsList!.add(ing);
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

  addRow(IngredientsList ingredientsList) {
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(ingredientsList.content!))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text(ingredientsList.quantity.toString()))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  pdmodel.ingredientsList!.remove(ingredientsList);
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
