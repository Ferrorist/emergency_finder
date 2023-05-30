import 'package:flutter/material.dart';
import '../screens/fullscreen_map.dart';
import '../widgets/hospital_card.dart';
import '../models/hospital_model.dart';
import 'dart:io';

class SearchDetailScreen extends StatefulWidget {
  String inputText;

  SearchDetailScreen({super.key, required this.inputText});

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  List<HospitalModel> HospitalInstances = [];
  final TextEditingController _textEditingController = TextEditingController();
  final HospitalModel _temphospitalModel1 = HospitalModel(
      name: "칠곡경북대학교병원",
      address: "대구광역시 북구 호국로 807, 칠곡경북대학교병원",
      department: ["치과"]);
  final HospitalModel _temphospitalModel2 = HospitalModel(
      name: "대구가톨릭대학교칠곡가톨릭병원",
      address: "대구광역시 북구 칠곡중앙대로 440",
      department: ["치과"]);
  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.inputText;
    HospitalInstances.add(_temphospitalModel1);
    HospitalInstances.add(_temphospitalModel2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
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
                  HospitalCard(hospital: _temphospitalModel1),
                  HospitalCard(hospital: _temphospitalModel2),
                ],
              ),
            ),
          ],
        ),
      ),

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

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text('details'),
    );
  }
}
