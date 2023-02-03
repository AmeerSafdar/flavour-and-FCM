// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_declarations, use_key_in_widget_constructors, library_private_types_in_public_api, unused_element, prefer_const_constructors, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task06/bloc/bloc.dart';
import 'package:task06/bloc/event.dart';
import 'package:task06/bloc/states.dart';
import 'package:task06/config/app_config.dart';
import 'package:task06/helper/const/common_const.dart';
import 'package:task06/helper/extension/string_extension.dart';
import 'package:task06/helper/const/stringsHelper.dart';

mainCommon(FlavorConfig config) async {
  CommonConst.flavorConfig = StateProvider((ref) => config);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initializeFlutterFire();
  FirebaseMessaging.onBackgroundMessage(CommonConst.notifyHelper.firebaseMessagingBackgroundHandler);
  CommonConst.notifyHelper.getMessage();
  runZonedGuarded(() {
    runApp(
      ProviderScope(
        child: 
        MyApp(),
      ),
    );
  }, ((error, stackTrace) {
    CommonConst.crashLytics.recordError(error, stackTrace);
  }));
}
Future<void> _initializeFlutterFire() async {
  if (CommonConst.kTestingCrashlytics) {
    await CommonConst.crashLytics.setCrashlyticsCollectionEnabled(true);
  } else if (kDebugMode) {
    await CommonConst.crashLytics.setCrashlyticsCollectionEnabled(true);
  } else {
    CommonConst.crashLytics.setCrashlyticsCollectionEnabled(true);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: ((context) => MainBloc()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetData());
    CommonConst.notifyHelper.getMessage();
  }

  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of<MainBloc>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Consumer(
            builder: ((context, ref, child) => Text(ref
                .watch<FlavorConfig>(CommonConst.flavorConfig)
                .appTitle!)),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: BlocBuilder<MainBloc, States>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(state.status==Status.fetchData && state.data!.isNotEmpty)
                    Text(state.data!).textStyle()
                  else
                    Center(
                      child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()) 
                      )
                    ,
                  SizedBox(
                    height: 15,
                  ),
    
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: ()=>bloc.add(CrashApp()),
                        child: Text(StringHelper.btnText)
                        ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
