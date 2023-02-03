// ignore_for_file: prefer_const_constructors

import 'package:task06/config/app_config.dart';
import 'package:task06/helper/const/stringsHelper.dart';
import 'package:task06/presentation_layer/views/main_common.dart';

void main() {
  mainCommon(
    FlavorConfig()
      ..appTitle = StringHelper.acceptance
  );
}