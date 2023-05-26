import 'package:flutter/material.dart';
import '../services/gps_service.dart';

class details extends StatelessWidget {
  const details ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상세페이지'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text('상세페이지'),
        ),
      ),
    );
  }
}
