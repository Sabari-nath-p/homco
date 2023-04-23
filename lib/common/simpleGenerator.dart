import 'package:flutter/material.dart';

TextEditingController TextcontrollerGenerator(String value) {
  TextEditingController textEditingController = new TextEditingController();
  textEditingController.text = value;
  return textEditingController;
}
