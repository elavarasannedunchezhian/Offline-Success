import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:realm/realm.dart';
import 'package:shopping/service/user_service.dart';
import 'package:shopping/splash.dart';

const appId = "devicesync-qcddd";

void main() {
  final App atlasApp = App(AppConfiguration(appId));
  final UserService userService = UserService(atlasApp);
  runApp(MyApp(
    userService: userService,
  ));
}

class MyApp extends StatelessWidget {
  final UserService userService;
  final InternetConnectionChecker _internetConnectionChecker = InternetConnectionChecker();
  
  MyApp({super.key, required this.userService}) {
    startMonitoring();
  }

  void startMonitoring() {
    _internetConnectionChecker.onStatusChange.listen((status) { 
      if(status == InternetConnectionStatus.connected) {
        print('Internet = $status');
      } else if(status == InternetConnectionStatus.connected) {
        print('Internet = $status');
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(
        userService: userService,
      ),
    );
  }
}