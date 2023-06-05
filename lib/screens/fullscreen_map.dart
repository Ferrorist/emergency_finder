import 'dart:io';
import '../widgets/naverMap_widget.dart';
import 'package:flutter/material.dart';
import '../services/gps_service.dart';

class FullscreenMap extends StatelessWidget {
  FullscreenMap({super.key});

  Future<bool> isdetermined = GPSService.checkPermission();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: isdetermined,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return NaverMap(
                ViewType: "UserNaverMap",
              );
            } else {
              return const Center(
                child: Text(
                  "Permission is denied",
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: !Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            )
          : null,
      floatingActionButtonLocation:
          !Platform.isAndroid ? FloatingActionButtonLocation.endFloat : null,
    );
  }
}
