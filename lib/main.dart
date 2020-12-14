import 'package:flutter/material.dart';
import 'package:bookapp/theme/colors.dart';
import 'package:bookapp/mybottombardemo.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: primary,
  ),
  home: MyBottomBarDemo(),
));
