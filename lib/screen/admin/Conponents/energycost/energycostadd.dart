import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/Color.dart';
import 'package:homco/model/energycostModel.dart';
import 'package:homco/model/rawMaterial.dart';
import 'package:homco/screen/admin/Conponents/RawMaterial/rawmateriallist.dart';
import 'package:homco/screen/admin/Conponents/energycost/energycostlist.dart';
import 'package:homco/screen/splash/splashmain.dart';

import '../../../estimation/textstyle.dart';
import '../../common/addText.dart';

class energycostadd extends StatefulWidget {
  ValueNotifier notifier;
  var editcheck;
  energycostadd({super.key, this.editcheck = null, required this.notifier});

  @override
  State<energycostadd> createState() => _energycostaddState();
}

class _energycostaddState extends State<energycostadd> {
  TextEditingController nameText = TextEditingController();
  TextEditingController priceText = TextEditingController();

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
      EnergyCostModel rm = widget.editcheck;
      nameText.text = rm.categoryName!;
      priceText.text = rm.price.toString();
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
                child:
                    TypeSelectionText("Category Name ", nameText, Categories),
              ),
              InkWell(
                onTap: () async {
                  if (nameText.text.isNotEmpty && priceText.text.isNotEmpty) {
                    EnergyCostModel md = EnergyCostModel(
                      categoryName: nameText.text.trim(),
                      price: double.parse(priceText.text.trim()),
                    );
                    Box dp = await Hive.openBox("ENERGYCOST");
                    dp.put(nameText.text.trim().toUpperCase(), md);
                    print(md.toJson());
                    if (widget.editcheck != null) {
                      energycostEditCheck = null;
                      widget.notifier.value++;
                    }
                    setState(() {
                      nameText.text = "";
                      priceText.text = "";
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
                    "Add Energy Cost",
                    style: tbox(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          TypeText("Price", priceText, width: 100),
        ],
      ),
    );
  }
}
