import 'dart:async';
import 'package:flutter/material.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import 'dart:convert';
import '../constants/Constants.dart';
import '../widgets/SlideView.dart';
import '../pages/GoodDetailPage.dart';
import '../widgets/CommonEndLine.dart';
import '../model/GoodItem.dart';
import '../widgets/SlideViewIndicator.dart';
import 'package:flutter_buy/util/ThemeUtils.dart';
import '../widgets/CatView.dart';

class TaobaoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TaobaoPageState();
}

class TaobaoPageState extends State<TaobaoPage> {
  final ScrollController _controller = new ScrollController();

  var listData;
  var slideData;
  var curPage = 1;
  SlideView slideView;
  var listTotalSize = 0;
  SlideViewIndicator indicator;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        // scroll to bottom, get next page data
//        print("load more ... ");
        curPage++;
        getDataList(true);
      }
    });
    getDataList(false);
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getDataList(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 无数据时，显示Loading
    if (listData == null) {
      return new Center(
        // CircularProgressIndicator是一个圆形的Loading进度条
        child: new CircularProgressIndicator(),
      );
    } else {
      // 有数据，显示ListView
      Widget listView = new ListView.builder(
        itemCount: listData.length * 2,
        itemBuilder: (context, i) => renderRow(i),
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  // 从网络获取数据，isLoadMore表示是否是加载更多数据
  getDataList(bool isLoadMore) {
    String url = Api.TAO_BAO_LIST;
    url += "&page=$curPage";
    print('url:' + url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        if (map['er_code'] == 10000) {
          var data = map['data'];
          listTotalSize = data['total'];
          var _listData = data['list'];
          var _slideData = Constants.LUN_BO_MAP;
          setState(() {
            //通过setState方法更新数据,setState告诉flutter,这个state中的值发生变化，应该调用build更新界面
            if (!isLoadMore) {
              listData = _listData;
              slideData = _slideData;
            } else {
              listData.addAll(_listData);
              // 判断是否获取了所有的数据，如果是，则需要显示底部的"我也是有底线的"布局
              if (listData.length >= listTotalSize) {
                listData.add(Constants.END_LINE_TAG);
              }
            }
            initSlider();
          });
        }
      }
    });
  }

  void initSlider() {
    indicator =
        new SlideViewIndicator(slideData == null ? 0 : slideData.length);
    slideView = new SlideView(slideData, indicator);
  }

  Widget renderRow(i) {
    if (i == 0) {
      return new Column(
          mainAxisSize:MainAxisSize.min,
          children: <Widget>[
        new Container(
          height: 150.0,
          child: new Stack(
            children: <Widget>[
              slideView,
              new Container(
                alignment: Alignment.bottomCenter,
                child: indicator,
              )
            ],
          ),
        ),
        new CatView()
      ]);
    }
    i -= 1;
    //是否奇数
    if (!i.isOdd) {
      return new Divider(height: 1.0);
    }
    i = i ~/ 2;
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
          child: new Text(itemData['goods_title'],
              style: ThemeUtils.titleTextStyle),
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

    var xianjia = (double.parse(itemData['goods_price']) -
            double.parse(itemData['coupon_price']))
        .toStringAsFixed(2);
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
                  new Text(itemData['goods_price'],
                      style: ThemeUtils.subtitleStyle),
                  new Text('--------', style: ThemeUtils.subtitleStyle)
                ]),
            new Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
              child: new Text(xianjia.toString(),
                  style: ThemeUtils.emphasizeStyle),
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
          return new GoodDetailPage(
              goodItem: GoodItem.convertGoodItem(itemData));
        }));
      },
    );
  }
}
