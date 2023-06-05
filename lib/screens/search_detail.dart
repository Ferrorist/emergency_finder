
import 'package:flutter/foundation.dart';
// web
// import 'dart:html';
import 'package:flutter/material.dart';
import '../screens/fullscreen_map.dart';
import '../widgets/hospital_card.dart';
import '../models/hospital_model.dart';
import 'package:geolocator/geolocator.dart';
// android
import 'dart:io';


import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchDetailScreen extends StatefulWidget {
  String inputText;

  SearchDetailScreen({Key? key, required this.inputText}) : super(key: key);

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  List<HospitalModel> hospitalInstances = [];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.inputText;
    fetchHospitalData();
  }

  Future<void> fetchHospitalData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String apiUrl =
          'http://127.0.0.1:8000/api/v1/radius_finder/${position.longitude}/${position.latitude}';
      http.Response response = await http.get(Uri.parse(apiUrl));
      List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes ?? []));

      List<HospitalModel> hospitals = await Future.wait(responseData.map((data) async {
        return HospitalModel.fromJsonWithLocation(data);
      }).toList());

      setState(() {
        hospitalInstances.addAll(hospitals);
      });
    } catch (e) {
      print('Error fetching hospital data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 40,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "증상",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: hospitalInstances.length,
                    itemBuilder: (context, index) {
                      HospitalModel hospital = hospitalInstances[index];
                      print(hospital);
                      return HospitalCard(hospital: hospital);
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),


      //웹 작동
      // floatingActionButton: (() {
      //   if (kIsWeb) {
      //     return Stack(
      //       children: [
      //         Positioned(
      //           bottom: 13,
      //           right: 16,
      //           child: FloatingActionButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //             child: const Icon(Icons.arrow_back),
      //           ),
      //         ),
      //         Positioned(
      //           bottom: 90,
      //           right: 16,
      //           child: FloatingActionButton(
      //             heroTag: 'map',
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: ((context) => FullscreenMap()),
      //                 ),
      //               );
      //             },
      //             child: const Icon(Icons.map_outlined),
      //           ),
      //         ),
      //       ],
      //     );
      //   } else {
      //     return FloatingActionButton(
      //       heroTag: 'map',
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: ((context) => FullscreenMap()),
      //           ),
      //         );
      //       },
      //       child: const Icon(Icons.map_outlined),
      //     );
      //   }
      // })(),
      //




      // 안드로이드만 작동가능
      // 안드로이드 기기가 아닌 경우 뒤로가기 버튼 활성화
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              heroTag: 'map',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => FullscreenMap()),
                  ),
                );
              },
              child: const Icon(Icons.map_outlined),
            )
          : Stack(
              children: [
                Positioned(
                  bottom: 13,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Positioned(
                  bottom: 90,
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: 'map',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => FullscreenMap()),
                        ),
                      );
                    },
                    child: const Icon(Icons.map_outlined),
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation:
          !Platform.isAndroid ? FloatingActionButtonLocation.endFloat : null,
    );
  }
}

