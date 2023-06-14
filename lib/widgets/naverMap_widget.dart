import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class NaverMap extends StatelessWidget {
  NaverMap(
      {super.key,
      hospitals,
      required this.ViewType,
      required this.isTrackingUser});
  final String ViewType;
  final bool isTrackingUser; // 네이저 지도가 유저 위치를 보여줄 것인지
  late Map<String, dynamic> hospitals = {}; // 병원 정보를 담는 Map

  @override
  Widget build(BuildContext context) {
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
            'isTrackingUser': isTrackingUser,
            'hospitals': hospitals,
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
  }
}
