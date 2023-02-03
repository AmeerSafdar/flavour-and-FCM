// ignore_for_file: prefer_const_constructors, unnecessary_type_check


import 'package:flutter/material.dart';

extension StringExtension on Text{
  Text textStyle() {
      Text t = this;
      return Text(
        t.data!,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500
        ),
      );
      }
}