import 'package:flutter/material.dart';
import '../services/gps_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/detail_map.dart';
import 'find_emergency.dart';

class details extends StatelessWidget {
  const details({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.address,
    required this.department,
    required this.phonenumber,
    required this.congestion,
    required this.major,
    required this.fromtodistance,
  }) : super(key: key);

  final double latitude;
  final double longitude;
  final String name;
  final String address;
  final String phonenumber;
  final List<String> department;
  final int congestion;
  final String? major;
  final double? fromtodistance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // 뒤로가기 버튼을 눌렀을 때 수행할 작업을 정의
      // 이전 화면으로 돌아가도록 Navigator.pushReplacement를 호출할 수 있습니다.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FindEmergency(),
        ),
      );
      return true; // true를 반환하면 뒤로가기 이벤트가 처리됩니다.
    },
    child: Scaffold(
    appBar: AppBar(
    title: const Text('상세페이지'),
    ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: [MapScreen(latitude: latitude, longitude: longitude),
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
                              'https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F408%2F2022%2F08%2F19%2F0000164664_013_20220819172101997.jpg&type=a340'),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            alignment: Alignment.center, // 중앙 정렬 설정
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  '${department} ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '$phonenumber',
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
                    mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬 설정
                    children: [
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.phone),
                          iconSize: 70,
                          onPressed: () {
                            launchPhoneApp(phonenumber);
                          },
                        ),
                      ),
                      const Text('혼잡 확률은 108% 입니다.')
                    ],
                  ),
                )


              ],
            ),


          ],
        ),
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