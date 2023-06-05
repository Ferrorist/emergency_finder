import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../services/gps_service.dart';

class NaverMap extends StatelessWidget {
  NaverMap({super.key, required this.ViewType});
  final String ViewType;
  static const platform = MethodChannel("UserNaverMap");
  late Position user_position;

  Future<void> FindUserLocation() async {
    user_position = await GPSService.getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FindUserLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return PlatformViewLink(
            viewType: ViewType,
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                  controller: controller as AndroidViewController,
                  hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                  gestureRecognizers: const <Factory<
                      OneSequenceGestureRecognizer>>{});
            },
            onCreatePlatformView: (params) {
              return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: ViewType,
                layoutDirection: TextDirection.ltr,
                creationParams: <String, dynamic>{
                  'latitude': user_position.latitude,
                  'longitude': user_position.longitude,
                },
                creationParamsCodec: const StandardMessageCodec(),
                onFocus: () {
                  params.onFocusChanged(true);
                },
              )
                ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                ..create();
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
