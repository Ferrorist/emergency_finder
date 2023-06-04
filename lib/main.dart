import '../services/gps_service.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_naver_map/flutter_naver_map.dart';
import '../screens/find_emergency.dart';
import '../screens/permission_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/details': (context) => const details(),
      // },
      home: Scaffold(
        body: FutureBuilder(
          future: GPSService.checkPermission(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == true) {
              return const FindEmergency();
            } else {
              return const PermissionScreen();
            }
          },
        ),
      ),
    );
  }
}
