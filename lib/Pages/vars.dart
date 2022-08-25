import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var localFile = Hive.box('todoList');
List<dynamic> tasks = [];
List<dynamic> isChecked = [];

List<TextDecoration> isCrossed = [
  TextDecoration.lineThrough,
  TextDecoration.none,
  TextDecoration.none
];
