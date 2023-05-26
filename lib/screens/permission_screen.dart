import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import '../services/gps_service.dart';
import '../screens/find_emergency.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GPSService.requestPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data == true) {
            return const FindEmergency();
          } else {
            return AlertDialog(
              title: const Text("권한 거부"),
              content: const Text("위치 권한을 허가해주세요.\n원할한 서비스를 이용할 수 있습니다."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings().then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FindEmergency(),
                        ),
                      );
                    });
                  },
                  child: const Text("페이지 이동"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FindEmergency(),
                        ));
                  },
                  child: const Text("무시"),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
