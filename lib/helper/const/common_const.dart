// ignore_for_file: prefer_const_declarations, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:task06/helper/notification_helper/notifyHelper.dart';

class CommonConst{
  static final crashLytics=FirebaseCrashlytics.instance;
  static final kTestingCrashlytics = true;
  static var flavorConfig;
  static final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  static final NotificationHelper notifyHelper = NotificationHelper();
}