import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../screens/search_detail.dart';
import '../services/gps_service.dart';


class FindEmergency extends StatefulWidget {
  const FindEmergency({super.key});

  @override
  State<FindEmergency> createState() => _FindEmergencyState();
}

class _FindEmergencyState extends State<FindEmergency> {
  final TextEditingController _textEditingController = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = '';

  @override
  void initState() {
    super.initState();
    _initializeSpeechToText();
  }

  /// This has to happen only once per app
  void _initializeSpeechToText() async {
    bool available = await _speechToText.initialize();
    if (mounted) {
      setState(() {
        _isListening = available;
      });
    }
  }

  /// Each time to start a speech recognition session
  void _startListening() {
    _speechToText.listen(
      onResult: (result) {
        setState(() {
          _transcription = result.recognizedWords;
          _textEditingController.text = _transcription;
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }


  void _stopListening() {
    _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('음성 입력'),
          content: TextField(
            controller: _textEditingController,
            onChanged: (value) {
              setState(() {
                _transcription = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }



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
                      controller: _textEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '증상을 입력해주세요.';
                        } else {
                          return null;
                        }
                      },
                      // 제출할 경우 발생하는 이벤트
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate() ) {
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
                  Row(
                    children: [
                      SizedBox(height: 20.0),
                      IconButton(
                        icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                        onPressed: () {
                          if (_isListening) {
                            _stopListening();
                          } else {
                            _startListening();
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                    ],
                  )
                ],
              ),
            ),
            // 위치 정보 권한이 없을 경우 텍스트 보여주기
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
          )

        ),

      );

  }
}

