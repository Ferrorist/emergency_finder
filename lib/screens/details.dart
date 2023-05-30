import 'package:flutter/material.dart';
import '../services/gps_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/detail_map.dart';

class details extends StatelessWidget {
  const details({Key? key,required this.latitude,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세페이지'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MapScreen(latitude: latitude,longitude: longitude,),
            Container(
              child: SizedBox(
                width: 300,
                height: 100,
                child: Row(
                  children: [
                    Image.network(
                        'https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F408%2F2022%2F08%2F19%2F0000164664_013_20220819172101997.jpg&type=a340'),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text('$name', textAlign: TextAlign.center),
                          Text('전화는 여기예요!', textAlign: TextAlign.center),
                          Text('$phonenumber', textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 100,
              child: Row(
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

          ]

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
