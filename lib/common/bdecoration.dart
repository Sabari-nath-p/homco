import 'package:flutter/material.dart';

import '../Color.dart';

tboxdecoration({double radius = 10}) => BoxDecoration(
    color: Colors.white.withOpacity(.66),
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: Colors.black45, width: 2.5));

buttonDecoration({double radius = 10}) => BoxDecoration(
      color: appLightGreen,
      borderRadius: BorderRadius.circular(radius),
    );
