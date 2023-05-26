import 'package:flutter/material.dart';
import '../screens/search_detail.dart';
import '../services/gps_service.dart';

class FindEmergency extends StatefulWidget {
  const FindEmergency({super.key});

  @override
  State<FindEmergency> createState() => _FindEmergencyState();
}

class _FindEmergencyState extends State<FindEmergency> {
  final _formKey = GlobalKey<FormState>();

  late Future<bool> isdetermined = GPSService.checkPermission();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  "병원 탐색",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '증상을 입력해주세요.';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchDetailScreen(
                                inputText: value,
                              ),
                            ),
                          );
                        }
                      },
                      // 제출 이벤트 감지
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "증상",
                        hintText: "환자가 겪고 있는 증상을 적어주세요.",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                FutureBuilder(
                  future: isdetermined,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == false) {
                        return const Text(
                          "위치 정보가 필요한 서비스입니다.\n위치 권한을 허용해주세요.",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            height: 2.3,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }
                    }
                    return const Text("");
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
      // 안드로이드 기기가 아닌 경우 뒤로가기 버튼 활성화
      // floatingActionButton: !Platform.isAndroid
      //     ? FloatingActionButton(
      //         heroTag: 'result',
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //         child: const Icon(Icons.arrow_back),
      //       )
      //     : null,
      // floatingActionButtonLocation:
      //     !Platform.isAndroid ? FloatingActionButtonLocation.endFloat : null,
    );
  }
}
