import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:homco/Color.dart';
import 'package:homco/screen/estimation/componets/estimateParameter.dart';

/// Example without a datasource
class ingredientList extends StatefulWidget {
  parameterConnector parameter;
  ingredientList({required this.parameter});

  @override
  State<ingredientList> createState() =>
      _ingredientListState(parameter: parameter);
}

class _ingredientListState extends State<ingredientList> {
  parameterConnector parameter;
  _ingredientListState({required this.parameter});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 674,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: appLightGreen)),
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
                    child: Text('SI.NO')),
                size: ColumnSize.S,
                fixedWidth: 50),
            DataColumn2(
                label: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.only(left: 4),
                  alignment: Alignment.center,
                  color: Colors.yellow.withOpacity(.5),
                  child: Text(
                    'CONTENT',
                  ),
                ),
                size: ColumnSize.M,
                fixedWidth: 200),
            DataColumn2(
              label: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(left: 4),
                alignment: Alignment.center,
                color: Colors.yellow.withOpacity(.5),
                child: Text(
                  'Quantity (%)',
                  textAlign: TextAlign.center,
                ),
              ),
              size: ColumnSize.M,
              fixedWidth: 100,
            ),
            DataColumn2(
                label: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 4),
                    height: double.infinity,
                    alignment: Alignment.center,
                    color: Colors.yellow.withOpacity(.5),
                    child: Text('Rate/Unit (Rs)')),
                size: ColumnSize.M,
                fixedWidth: 120),
            DataColumn2(
                label: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    color: Colors.yellow.withOpacity(.5),
                    child: Text('Cost/Batch (Rs)')),
                fixedWidth: 200),
          ],
          rows: [
            for (int i = 0; i < parameter.pmode.ingredient.length; i++)
              addRow(i)
          ]),
    );
  }

  addRow(index) {
  
    return DataRow(
      cells: [
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text("$index"))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text("${parameter.pmode.ingredient[index]}"))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text("${(parameter.pmode.ingredientQty[index] * 100)} %"))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Text("${parameter.pmode.ingredientPrice[index]}"))),
        DataCell(Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(right: 4),
            alignment: Alignment.center,
            child: Text(("${parameter.pmode.ingredientSub[index]}"))))
      ],
    );
  }
}
