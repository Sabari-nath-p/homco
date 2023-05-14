import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/Color.dart';
import 'package:homco/model/rawMaterial.dart';
import 'package:homco/screen/admin/Conponents/RawMaterial/rawmateriallist.dart';

import '../../../estimation/textstyle.dart';
import '../../common/addText.dart';

class rawmaterialadd extends StatefulWidget {
  ValueNotifier notifier;
  var editcheck;
  rawmaterialadd({super.key, this.editcheck = null, required this.notifier});

  @override
  State<rawmaterialadd> createState() => _rawmaterialaddState();
}

class _rawmaterialaddState extends State<rawmaterialadd> {
  TextEditingController nameText = TextEditingController();
  TextEditingController priceText = TextEditingController();
  TextEditingController unitText = TextEditingController();

  List units = ["ml", "gm"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.editcheck != null) {
      loadConnector();
    }
  }

  loadConnector() {
    setState(() {
      RawMaterialModel rm = widget.editcheck;
      nameText.text = rm.materialName!;
      priceText.text = rm.price.toString();
      unitText.text = rm.unit.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TypeText("Content Name ", nameText),
              ),
              InkWell(
                onTap: () async {
                  if (nameText.text.isNotEmpty &&
                      priceText.text.isNotEmpty &&
                      unitText.text.isNotEmpty) {
                    RawMaterialModel md = RawMaterialModel(
                        materialName: nameText.text.trim(),
                        price: double.parse(priceText.text.trim()),
                        unit: unitText.text);
                    Box dp = await Hive.openBox("RAWMATERIAL");
                    dp.put(nameText.text.trim().toUpperCase(), md);
                    print(md.toJson());
                    if (widget.editcheck != null) {
                      rawmaterialEditCheck = null;
                      widget.notifier.value++;
                    }
                    setState(() {
                      nameText.text = "";
                      priceText.text = "";
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
                    "Add Material",
                    style: tbox(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          TypeText("Price", priceText, width: 100),
          TypeSelectionText("Unit", unitText, units, width: 100)
        ],
      ),
    );
  }
}
