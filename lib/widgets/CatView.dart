import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../util/ThemeUtils.dart';

class CatView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CatViewState();
  }
}

class CatViewState extends State<CatView> {
  @override
  Widget build(BuildContext context) {
    return new Padding(padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
    child: GridView.count(
      crossAxisCount: 5,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: buildItem(10),
      shrinkWrap: true,
    ),);
  }

  List<Container> buildItem(int count) {
    return new List.generate(
        count,
        (int index) => new Container(
                child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  new Image.asset(Constants.CAT_ICON[index],width: 40, height: 40),
                  new Text(Constants.CAT_TITLE[index],
                      style: ThemeUtils.subtitleStyle)
                ])));
  }
}
