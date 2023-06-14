import 'package:flutter/material.dart';
import '../services/gps_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/detail_map.dart';
import 'find_emergency.dart';
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
          title: Row(
            children: [
              Text(name),
            ],
          ),
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
                  markerId: const MarkerId('location'),
                  position: LatLng(latitude, longitude),
                ),
              },
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 3),
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
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.local_hospital,
                                                  ),
                                                  const Text(' '),
                                                  Text(
                                                    department.join(', '),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.call,
                                                  ),
                                                  const Text(' '),
                                                  Text(
                                                    phoneNumber,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.accessibility),
                                                  const Text(' '),
                                                  Text(
                                                    '$congestion',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const Text(
                                                    '%',
                                                  ),
                                                ],
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
                                        child: ElevatedButton.icon(
                                            onPressed: () {
                                              launchPhoneApp(phoneNumber);
                                            },
                                            icon: const Icon(Icons.call,
                                                size: 20),
                                            label: Text(
                                              phoneNumber,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.green))),
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
