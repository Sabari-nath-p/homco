import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/model/packingMaterilModel.dart';
import 'package:homco/screen/admin/Conponents/packingMaterial/packingmateriallist.dart';
import 'package:homco/screen/admin/Conponents/product/productAdd.dart';

import '../../../../Color.dart';
import '../../../estimation/textstyle.dart';
import '../../common/addText.dart';

class packingmaterialadd extends StatefulWidget {
  var EditData;
  ValueNotifier notifier;
  packingmaterialadd({super.key, this.EditData = null, required this.notifier});

  @override
  State<packingmaterialadd> createState() => _packingmaterialaddState();
}

class _packingmaterialaddState extends State<packingmaterialadd> {
  TextEditingController packText = TextEditingController();
  TextEditingController qtyText = TextEditingController();
  TextEditingController priceText = TextEditingController();
  TextEditingController unitText = TextEditingController();
  List units = ["ml", "gm"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.EditData != null) {
      connectData();
    }
  }

  connectData() {
    packingmaterialModel pk = widget.EditData;
    packText.text = pk.packName!;
    priceText.text = pk.price!;
    unitText.text = pk.unit!;
    qtyText.text = pk.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TypeText("Pack Name ", packText),
              ),
              InkWell(
                onTap: () async {
                  if (packText.text.isNotEmpty &&
                      priceText.text.isNotEmpty &&
                      qtyText.text.isNotEmpty &&
                      unitText.text.isNotEmpty) {
                    packingmaterialModel pkmodel = packingmaterialModel(
                        packName: packText.text.trim(),
                        price: priceText.text.trim(),
                        unit: unitText.text.trim(),
                        quantity: double.parse(qtyText.text.trim()));
                    var db = await Hive.openBox("PACKINGMATERIAL");
                    db.put(packText.text.toUpperCase(), pkmodel);
                    db.close;
                    if (widget.EditData != null) {
                      packEditCheck = null;

                      widget.notifier.value++;
                    }
                    setState(() {
                      packText.text = "";
                      priceText.text = "";
                      qtyText.text = "";
                      unitText.text = "";
                    });
                  }
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
          TypeText("Pack Quantity", qtyText),
          TypeText("Pack Price", priceText),
          TypeSelectionText("Pack Unit", unitText, units)
        ],
      ),
    );
  }
}
