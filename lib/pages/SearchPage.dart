import 'package:flutter/material.dart';
import 'package:flutter_osc/pages/HotSearchPage.dart';
import 'package:flutter_osc/pages/SearchListPage.dart';
import 'package:flutter_osc/util/ThemeUtils.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/11/18
 *     desc  : 搜索页面
 *     revise:
 * </pre>
 */
class SearchPage extends  StatefulWidget{

  String search;
  SearchPage(searchStr){
    this.search = searchStr;
  }

  @override
  State<StatefulWidget> createState() {
    return new SearchState(search);
  }

}

class SearchState extends State<SearchPage> {

  TextEditingController searchController = new TextEditingController();
  SearchListPage searchListPage;
  String search ;

  SearchState(String search){
    this.search = search;
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = initSearchText();
    bool a = searchController.text==null||searchController.text.isEmpty;
    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                changeContent();
              }),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                setState(() {
                  searchController.clear();
                });
              }),
        ],
      ),
      body: (a)?
      new Center(
        //热门事件
        child : new HotSearchPage(),
      ):searchListPage,
    );
  }

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController(text: search);
    changeContent();
  }

  //改变内容
  void changeContent() {
    setState(() {
      //获取搜索的内容
      var text = searchController.text;
      searchListPage = new SearchListPage(id:text);
    });
  }

  TextField initSearchText() {
    TextField searchText = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        border: InputBorder.none,
        fillColor: ThemeUtils.colorWhite,
        hintText: '逗比，请输入搜索关键词',
      ),
      controller: searchController,
    );
    return searchText;
  }

}