import 'package:flutter/material.dart';

class ThemeUtils {
  // 默认主题色
  static const Color defaultColor = const Color(0xFFF2F2F2);

  // 可选的主题色
  static const List<Color> supportColors = [defaultColor, Colors.purple, Colors.orange, Colors.deepPurpleAccent, Colors.redAccent, Colors.blue, Colors.amber, Colors.green, Colors.lime, Colors.indigo, Colors.cyan, Colors.teal];

  // 当前的主题色
  static Color currentColorTheme = defaultColor;

  //常用颜色
  static Color emphasizeColor = Colors.red;
  static Color titleTextColor = const Color(0xFFFFFFFF);
  static Color contentTextColor = const Color(0xFFB5BDC0);
  static Color buttonTextColor = const Color(0xFFFFFFFF);

  static Color colorWhite = const Color(0xFFFFFFFF);

  //商品列表页
  static final TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  static final TextStyle subtitleStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);
  static final TextStyle emphasizeStyle = new TextStyle(color: Colors.red, fontSize: 12.0);

}