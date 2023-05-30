import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap(
      {super.key, required this.position, this.isUserposition = false});

  final Future<Position> position; // 표시하려는 포지션
  final bool isUserposition; // 해당 좌표가 사용자의 좌표인가?
  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  // GoogleMapController :
  // GoogleMap widget과 지도 서비스 사이의 다리 역할을 함.
  late GoogleMapController _controller;
  late LatLng targetCoordinates;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.position,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          targetCoordinates =
              LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: targetCoordinates,
              zoom: 14.3,
            ),
            // 지도에 파란 점으로 사용자의 현재 위치 표시
            myLocationEnabled: widget.isUserposition,
            onMapCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
