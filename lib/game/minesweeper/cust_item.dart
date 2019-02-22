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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: widget.backGroundColor,
      child: Center(
        child: Text(widget.info),
      )
    );
  }

}