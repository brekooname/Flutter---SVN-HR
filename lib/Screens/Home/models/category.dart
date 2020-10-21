import 'package:flutter/material.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class Category {
  Category(
      {this.title = '',
      this.imagePath = '',
      this.lessonCount = 0,
      this.money = 0,
      this.rating = 0.0,
      this.icon,
      this.index});

  String index;
  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;
  Icon icon;



}
