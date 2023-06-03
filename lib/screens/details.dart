import 'package:flutter/material.dart';
import '../services/gps_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/detail_map.dart';
import 'find_emergency.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.address,
    required this.department,
    required this.phoneNumber,
    required this.congestion,
    required this.major,
    required this.fromToDistance,
  }) : super(key: key);

  final double latitude;
  final double longitude;
  final String name;
  final String address;
  final String phoneNumber;
  final List<String> department;
  final int congestion;
  final String? major;
  final double? fromToDistance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // 이전 화면으로 돌아가기
        return true; // true를 반환하면 뒤로가기 이벤트가 처리됩니다.
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('상세페이지'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('location'),
                  position: LatLng(latitude, longitude),
                ),
              },
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Center(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        Image.network(
                                          'https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F408%2F2022%2F08%2F19%2F0000164664_013_20220819172101997.jpg&type=a340',
                                        ),
                                        Container(
                                          margin:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$name',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${department.join(', ')} ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              Text(
                                                '$phoneNumber',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 350,
                                height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.phone),
                                        iconSize: 70,
                                        onPressed: () {
                                          launchPhoneApp(phoneNumber);
                                        },
                                      ),
                                    ),
                                    const Text('혼잡 확률은 108% 입니다.'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void launchPhoneApp(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
