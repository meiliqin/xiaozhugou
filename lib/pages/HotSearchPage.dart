import 'package:flutter/material.dart';
import '../api/Api.dart';
import '../util/NetUtils.dart';
import 'dart:convert';
import 'package:flutter_osc/util/ThemeUtils.dart';
import 'package:flutter_osc/pages/SearchPage.dart';

/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/11/18
 *     desc  : 热门搜索页面
 *     revise:
 * </pre>
 */
final TextStyle emphasizeStyle_1=
new TextStyle(color: const Color(0xFFFD8144), fontSize: 15.0);
final TextStyle searchTextStyle = new TextStyle(color: const Color(0xFF000000), fontSize: 12.0);

class HotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HotSearchPageState();
  }
}

class HotSearchPageState extends State<HotSearchPage> {

  List<Widget> hotWidgets = new List();
  List<Widget> friendWidgets = new List();

  @override
  void initState() {
    super.initState();

    //获取热门关键字
    getHotKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text('热门搜索',
                style: emphasizeStyle_1)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: hotWidgets,
          ),
        ),
        new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text('搜索历史',
                style: emphasizeStyle_1)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: friendWidgets,
          ),
        ),
      ],
    );
  }


  //获取热门搜索
  void getHotKeywords() {
    String url = Api.TAO_BAO_HOT_SEARCH;
    NetUtils.get(url).then((data) {
      print('url:' + url);
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['er_code'] == 10000) {
          // code=0表示请求成功
          var dataHot = map['data'];
          List dataHotList = dataHot;
          List showdHotList = dataHotList.length > 10 ? dataHotList.sublist(
              0, 10) : dataHotList;
          hotWidgets.clear();
          print('showdHotList:' + showdHotList.length.toString());

          for (var value in showdHotList) {
            Widget actionChip = new ActionChip(
                backgroundColor: ThemeUtils.currentColorTheme,
                padding: EdgeInsets.all(1.0),
                label: new Text(
                  value['word'],
                  style: searchTextStyle,
                ),
                onPressed: () {
                Navigator
                    .of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (context) {
                  return new SearchPage(value['word']);
                }));
                });
            hotWidgets.add(actionChip);
          }
        }
      }
    });

    //获取搜索历史
    void getHistory() {
      var historyData = ["打底衫", "铅笔裤"];

      friendWidgets.clear();
      for (var itemData in historyData) {
        Widget actionChip = new ActionChip(
          backgroundColor: ThemeUtils.currentColorTheme,
          padding: EdgeInsets.all(1.0),
          label: new Text(
            itemData,
            style: searchTextStyle,
          ),
        );
        friendWidgets.add(actionChip);
      }
    }
  }
}
