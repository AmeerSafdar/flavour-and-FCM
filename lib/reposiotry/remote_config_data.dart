// ignore_for_file: use_rethrow_when_possible

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:task06/helper/const/common_const.dart';
import 'package:task06/helper/const/keys.dart';

class RemoteConfigData{
   Future<String> initConfig() async {
    try{
      await CommonConst.remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1),
      minimumFetchInterval: const Duration(
          seconds:5), 
    ));

    _fetchConfig();
    String a =CommonConst.remoteConfig.getString(CommonKeys.getTextkey);
    return a ;
    }
    catch(err){
      throw err;
    }
  }
  void _fetchConfig() async {
    await CommonConst.remoteConfig.fetchAndActivate();
  }
}