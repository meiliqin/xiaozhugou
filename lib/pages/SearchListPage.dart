import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_buy/util/NetUtils.dart';
import 'package:flutter_buy/api/Api.dart';
import 'dart:convert';
import '../constants/Constants.dart';
import '../widgets/CommonEndLine.dart';
import 'package:flutter_buy/util/ThemeUtils.dart';
import '../pages/GoodDetailPage.dart';
import '../model/GoodItem.dart';

class SearchListPage extends StatefulWidget {
  
  String id;
  SearchListPageState searchListPageState;
  SearchListPage({Key key, this.id}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return new SearchListPageState(id: this.id);
  }
}

class SearchListPageState extends State<SearchListPage> {
  String id;
  int curPage = 1;
  Map<String, String> map = new Map();
  List listData = new List();
  int listTotalSize = 0;
  ScrollController scrollController = new ScrollController();

  SearchListPageState({Key key, this.id});

  @override
  void initState() {
    super.initState();
    searchGood();
    addListener();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => renderRow(i),
        controller: scrollController,
      );
      return new RefreshIndicator(child: listView, onRefresh: pullToRefresh);
    }
  }

  Widget renderRow(i) {
    var itemData = listData[i];
    if (itemData['goods_pic'].startsWith("//")) {
      itemData['goods_pic'] = "https:" + itemData['goods_pic'];
    }
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new CommonEndLine();
    }
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(itemData['goods_title'], style: ThemeUtils.titleTextStyle),
        )
      ],
    );
    var saleRow = new Row(
      children: <Widget>[
        new Text(
          "月销量：",
          style: ThemeUtils.subtitleStyle,
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            itemData['goods_sales'],
            style: ThemeUtils.subtitleStyle,
          ),
        ),
        new Expanded(
            flex: 1,
            child: new Text(
              "评分4.9",
              style: ThemeUtils.subtitleStyle,
              textAlign: TextAlign.end,
            ))
      ],
    );

    var xianjia = double.parse(itemData['goods_price']) -
        double.parse(itemData['coupon_price']);
    var priceRow = new Row(
      children: <Widget>[
        new Image.asset('./images/ic_quan.png', width: 17, height: 12),
        new Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
            child: new Text("${itemData['coupon_price']}元",
                style: ThemeUtils.emphasizeStyle)),
        new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Stack(
                    alignment: const FractionalOffset(0.5, 0.5),
                    children: <Widget>[
                      new Text(itemData['goods_price'], style: ThemeUtils.subtitleStyle),
                      new Text('--------', style: ThemeUtils.subtitleStyle)
                    ]),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                  child: new Text(xianjia.toString(), style: ThemeUtils.emphasizeStyle),
                )
              ],
            ))
      ],
    );
    var imgUrl = itemData['goods_pic'];

    if (imgUrl != null && imgUrl.length > 0) {}
    var row = new Row(
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.all(6.0),
            child: new Image.network(
              imgUrl,
              fit: BoxFit.cover,
              width: 100.0,
              height: 100.0,
            )),
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                titleRow,
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: saleRow,
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: priceRow,
                )
              ],
            ),
          ),
        ),
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
          return new GoodDetailPage(goodItem: GoodItem.convertGoodItem(itemData));
        }));
      },
    );
  }


  //添加监听事件
  void addListener() {
    scrollController.addListener(() {
      var maxScroll = scrollController.position.maxScrollExtent;
      var pixels = scrollController.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        searchGood();
      }
    });
  }

  //刷新数据
  Future<Null> pullToRefresh() async {
    curPage = 1;
    searchGood();
    return null;
  }

  //请求接口搜索
  void searchGood() {
    String url = Api.TAO_BAO_SEARCH;
    url += "&key_word=$id";
    url += "&page=$curPage";
    print('url:' + url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['er_code'] == 10000) {
          var data = map['data'];
          listTotalSize = data["total"];
          var _listData = data['list'];
          setState(() {
            List list1 = new List();
            if (curPage == 1) {
              listData.clear();
            }
            curPage++;
            list1.addAll(listData);
            list1.addAll(_listData);
            if (list1.length >= listTotalSize) {
              list1.add(Constants.END_LINE_TAG);
            }
            listData = list1;
          });
        }
      }
    });
  }


}
