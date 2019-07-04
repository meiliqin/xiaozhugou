import 'package:flutter/material.dart';
import 'package:flutter_buy/util/ThemeUtils.dart';

class PinduoduoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PinduoduoPageState();
}

class PinduoduoPageState extends State<PinduoduoPage> {

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset('images/ic_zhu.png', width: 100.0, height: 100.0),
              new Text("敬请期待",
                  style: new TextStyle(
                      color: ThemeUtils.contentTextColor,
                      fontSize: 16.0)),
            ]));
  }
}