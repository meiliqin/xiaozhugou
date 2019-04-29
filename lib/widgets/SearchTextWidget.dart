import 'package:flutter/material.dart';
import 'package:flutter_osc/pages/SearchPage.dart';

class SearchTextWidget extends StatelessWidget {
  final TextStyle subtitleStyle =
  new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);

  Widget buildTextField() {
    // theme设置局部主题
    return Theme(
      data: new ThemeData(primaryColor: Colors.grey),
      child: new Row(
          children: <Widget>[
            new Icon(Icons.search),
            new Text("搜索商品", style: subtitleStyle),
          ]

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          print("Container clicked");
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (ctx) => new SearchPage("")));
        },
        child: Container(
          // 修饰搜索框, 白色背景与圆角
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
          ),
          alignment: Alignment.center,
          height: 36,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: buildTextField(),
        )
    );
  }

}

