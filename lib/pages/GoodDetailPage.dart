import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_osc/util/ThemeUtils.dart';
import '../model/GoodItem.dart';
import '../constants/Constants.dart';

class GoodDetailPage extends StatefulWidget {
  GoodItem goodItem;

  GoodDetailPage({Key key, this.goodItem}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new GoodDetailPageState(goodItem: this.goodItem);
}

class GoodDetailPageState extends State<GoodDetailPage> {
  GoodItem goodItem;

  GoodDetailPageState({Key key, this.goodItem});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("商品详情")),
      body: new Column(children: <Widget>[
        new Expanded(
            flex: 1,
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.network(
                    goodItem.pic,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                  new Padding(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: new Row(children: <Widget>[
                        new Expanded(
                            flex: 1,
                            child: new Text("¥${goodItem.xianjia}",
                                style: new TextStyle(
                                    color: ThemeUtils.emphasizeColor,
                                    fontSize: 20.0))),
                        new Expanded(
                          flex: 1,
                          child: new Text("原价 ¥${goodItem.yuanjia}",
                              style: new TextStyle(
                                  color: ThemeUtils.contentTextColor,
                                  fontSize: 14.0)),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Text("月销 ${goodItem.sales}",
                              style: new TextStyle(
                                  color: ThemeUtils.contentTextColor,
                                  fontSize: 14.0)),
                        )
                      ])),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child:
                        new Text(goodItem.title, style: new TextStyle(fontSize: 16.0)),
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                      child: new Container(
                          height: 40.0,
                          width: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("images/bg_quan.jpg"),
                            fit: BoxFit.contain,
                          )),
                          child: Center(
                            child: Text(
                              '券${goodItem.couponPrice}元',
                              style: new TextStyle(
                                  color: ThemeUtils.emphasizeColor,
                                  fontSize: 16.0),
                            ),
                          ))),
                ])),
        new RaisedButton(
          onPressed: _launchURL,
          color: Colors.red,
          child:
          new Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child:new Text("领券购买",
              style: new TextStyle(
              color: ThemeUtils.buttonTextColor,
              fontSize: 16.0))),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

        )
      ]),
    );
  }

  _launchURL() async {
    //const url = 'https://www.baidu.com';
    String url=getUrl(goodItem.couponId, goodItem.goodId, Constants.PID);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _log() {
    print("点击了按钮");
  }

  String getUrl(String couponId,String goodId,String pid){
   print("=======我拼接时候获取到的PID是:"+pid);
    return "https://uland.taobao.com/coupon/edetail?activityId="+couponId+"&pid="+pid+"&itemId="+goodId+"&src=qtka_wxxt&dx=1";
  }
}

class ParentWidget extends StatefulWidget {
  @override
  State<ParentWidget> createState() => ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
