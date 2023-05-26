import 'package:flutter/material.dart';
//import 'package:flutter_naver_map/flutter_naver_map.dart';
import '../screens/find_emergency.dart';
import '../screens/details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NaverMapSdk.instance.initialize(
  //   clientId: 'wxgjpwwj0u',
  // );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:  {
        '/': (context) => FindEmergency(),
        '/details': (context) => details(),
      },
    );
  }
}
