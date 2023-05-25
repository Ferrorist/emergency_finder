import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class MyNaverMap extends StatelessWidget {
  const MyNaverMap({
    super.key,
    required this.user_position,
  });

  final Future<Position> user_position;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user_position,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: NLatLng(
                  snapshot.data!.latitude,
                  snapshot.data!.longitude,
                ),
                zoom: 16,
              ),
              // 실내 지도 활성화 유무
              indoorEnable: true,
              // 표시할 정보 레이어
              activeLayerGroups: [
                // 건물 레이어
                NLayerGroup.building,
              ],
            ),
            onMapReady: (controller) {
              NMarker userMarker = NMarker(
                id: "User",
                position: NLatLng(
                  snapshot.data!.latitude,
                  snapshot.data!.longitude,
                ),
                size: const Size(20, 30),
              );
              controller.addOverlay(userMarker);
            },
          );
        } else {
          return const Center(
            child: Text("Find User Position..."),
          );
        }
      },
    );
  }
}
