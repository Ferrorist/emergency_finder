import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/gps_service.dart';
import '../widgets/googlemap_widget.dart';
import '../widgets/userMap_widget.dart';

class FullscreenMap extends StatelessWidget {
  FullscreenMap({super.key});

  final Future<Position> user_position = GPSService.getPosition();
  Future<bool> isdetermined = GPSService.checkPermission();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: isdetermined,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return const userMapWidget(
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
