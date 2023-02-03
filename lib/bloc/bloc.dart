// ignore_for_file: use_rethrow_when_possible, non_constant_identifier_names

import 'package:task06/bloc/event.dart';
import 'package:task06/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task06/helper/const/common_const.dart';
import 'package:task06/reposiotry/remote_config_data.dart';
class MainBloc extends Bloc<Events, States> {
  RemoteConfigData rem=RemoteConfigData();
  MainBloc() : super(States()) {
   on<CrashApp>(_crashApp);
   on<GetData>(_getData);
  }
  _getData(GetData event, Emitter<States> emit) async{
    try{
      String remoteData= await rem.initConfig() ;
    emit(
      state.copyWith(
        status: Status.fetchData,
        data: remoteData
      )
    );
    }
    catch(e){
      throw e;
    }
  }

  _crashApp(CrashApp event, Emitter<States> emit){
    try {
      CommonConst.crashLytics.crash();
    } catch (err) {
      throw err;
    }

  }
}