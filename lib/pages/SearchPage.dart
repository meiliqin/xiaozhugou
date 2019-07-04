import 'package:flutter/material.dart';
import 'package:flutter_buy/pages/HotSearchPage.dart';
import 'package:flutter_buy/pages/SearchListPage.dart';
import 'package:flutter_buy/util/ThemeUtils.dart';

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
  FocusNode _contentFocusNode = FocusNode();
  SearchListPage searchListPage;
  String search ;

  SearchState(String search){
    this.search = search;
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = initSearchText();
    bool a = searchController.text==null||searchController.text.isEmpty;
    print('text:' + searchController.text);
   //if(a) searchListPage = new SearchListPage(id:searchController.text);
    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                _contentFocusNode.unfocus();
                _onChangeContent(searchController.text);
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
//    changeContent();
    _onChangeContent(searchController.text);
  }

  //改变内容
  void changeContent() {
    setState(() {
      //获取搜索的内容
      var text = searchController.text;
     // if(searchListPage==null){
        searchListPage = new SearchListPage(id:searchController.text);
    //  }
    });
  }

  TextField initSearchText() {
    TextField searchText = new TextField(
      focusNode: _contentFocusNode,
      decoration: new InputDecoration(
        border: InputBorder.none,
        fillColor: ThemeUtils.colorWhite,
        hintText: '逗比，请输入搜索关键词',
      ),
      controller: searchController,
      onChanged: _onChangeContent,
    );
    return searchText;
  }


  void _onChangeContent(String value){
    setState(() {
      searchListPage = new SearchListPage(id:value);
    });
  }

}