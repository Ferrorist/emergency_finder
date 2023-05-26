import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/gps_service.dart';
import '../widgets/navermap_widget.dart';

class FullscreenMap extends StatelessWidget {
  const FullscreenMap({super.key});

  // final Future<Position> user_position = GPSService.getPosition();
  // Future<bool> isdetermined = GPSService.determinePermission();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "개발 중...",
        ),
      ),
      // body: FutureBuilder(
      //   future: isdetermined,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data == true) {
      //         return MyNaverMap(userPosition: user_position);
      //       } else {
      //         return const Center(
      //           child: Text(
      //             "Permission is denied",
      //           ),
      //         );
      //       }
      //     } else {
      //       return const Center(
      //         child: Text(
      //           "Loading...",
      //         ),
      //       );
      //     }
      //   },
      // ),
      // floatingActionButton: !Platform.isAndroid
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //         child: const Icon(Icons.arrow_back),
      //       )
      //     : null,
      // floatingActionButtonLocation:
      //     !Platform.isAndroid ? FloatingActionButtonLocation.endFloat : null,
    );
  }
}
