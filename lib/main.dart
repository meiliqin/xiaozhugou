import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_buy/util/ThemeUtils.dart';
import 'pages/TaobaoPage.dart';
import 'pages/PinduoduoPage.dart';
import 'pages/JingdongPage.dart';
import 'pages/MyInfoPage.dart';
import './widgets/SearchTextWidget.dart';

void main() {
  //强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(new MyAppClient());
}
class MyAppClient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppClientState();
}
class MyAppClientState extends State<MyAppClient> {
  final appBarTitles = ['淘宝', '拼多多','京东',  '我的'];
  int _tabIndex = 0;
  var tabImages;
  var _body;
  var pages;

  @override
  void initState() {
    super.initState();
    pages = <Widget>[
      new TaobaoPage(),
      new PinduoduoPage(),
      new JingdongPage(),
      new MyInfoPage()
    ];
   initTabImage();
  }

  @override
  Widget build(BuildContext context) {
    _body = new IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    return new MaterialApp(
      theme: new ThemeData(
          primaryColor: ThemeUtils.currentColorTheme
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: SearchTextWidget(),
        ),
        body: _body,
        bottomNavigationBar: new CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1),
                title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2),
                title: getTabTitle(2)),
            new BottomNavigationBarItem(
                icon: getTabIcon(3),
                title: getTabTitle(3)),
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            setState((){
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return ThemeUtils.tabTextStyleSelected;
    }
    return ThemeUtils.tabTextStyleNormal;
  }
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }
  void initTabImage(){
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_nav_tb.png'),
          getTabImage('images/ic_nav_tb.png')
        ],
        [
          getTabImage('images/ic_nav_pd.png'),
          getTabImage('images/ic_nav_pd.png')
        ],
        [
          getTabImage('images/ic_nav_jd.png'),
          getTabImage('images/ic_nav_jd.png')
        ],
        [
          getTabImage('images/ic_zhu.png'),
          getTabImage('images/ic_zhu.png')
        ]
      ];
    }
  }
}

