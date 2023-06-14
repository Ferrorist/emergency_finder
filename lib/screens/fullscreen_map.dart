import 'dart:io';
import 'package:flutter/services.dart';

import '../widgets/naverMap_widget.dart';
import 'package:flutter/material.dart';
import '../services/gps_service.dart';

class FullscreenMap extends StatefulWidget {
  const FullscreenMap({super.key});

  @override
  State<FullscreenMap> createState() => _FullscreenMapState();
}

class _FullscreenMapState extends State<FullscreenMap> {
  final MethodChannel _methodChannel = const MethodChannel('fullscreen');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'handelBackPressed') {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _methodChannel.setMethodCallHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _methodChannel.invokeMethod('handleBackPressed');
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: NaverMap(
          ViewType: "UserNaverMap",
          isTrackingUser: true,
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
            Platform.isAndroid ? FloatingActionButtonLocation.endFloat : null,
      ),
    );
  }
}
