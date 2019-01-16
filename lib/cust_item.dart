import 'package:flutter/material.dart';

class CustItem extends StatefulWidget {

  Color backGroundColor;
  String info;

  CustItem({Key key, this.backGroundColor, this.info}):super(key: key);

  @override
  State<StatefulWidget> createState() {

    return _CustItem();
  }

}

class _CustItem extends State<CustItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: widget.backGroundColor,
      child: Center(
        child: Text(widget.info),
      )
    );
  }

}