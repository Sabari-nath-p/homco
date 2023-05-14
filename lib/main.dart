import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homco/model/energycostModel.dart';
import 'package:homco/model/manpowerModel.dart';
import 'package:homco/model/packingMaterilModel.dart';
import 'package:homco/model/productsModel.dart';
import 'package:homco/model/rawMaterial.dart';
import 'package:homco/screen/splash/splashmain.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(RawMaterialModelAdapter().typeId))
    Hive.registerAdapter(RawMaterialModelAdapter());
  if (!Hive.isAdapterRegistered(productModelAdapter().typeId))
    Hive.registerAdapter(productModelAdapter());
  if (!Hive.isAdapterRegistered(IngredientsListAdapter().typeId))
    Hive.registerAdapter(IngredientsListAdapter());
  if (!Hive.isAdapterRegistered(packingmaterialModelAdapter().typeId))
    Hive.registerAdapter(packingmaterialModelAdapter());
  if (!Hive.isAdapterRegistered(manpowerModelAdapter().typeId))
    Hive.registerAdapter(manpowerModelAdapter());
  if (!Hive.isAdapterRegistered(PackingAdapter().typeId))
    Hive.registerAdapter(PackingAdapter());
  if (!Hive.isAdapterRegistered(EnergyCostModelAdapter().typeId))
    Hive.registerAdapter(EnergyCostModelAdapter());

  runApp(const homco());
}

class homco extends StatelessWidget {
  const homco({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      home: splashMain(),
    );
  }
}
