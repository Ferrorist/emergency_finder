import 'package:flutter/material.dart';

class NumberCircle extends StatelessWidget {
  final int congestion;

  NumberCircle({super.key, required this.congestion});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = getColorFromNumber(congestion);

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          congestion.toString()+'%',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color getColorFromNumber(int congestion) {
    if (congestion < 30) {
      return Colors.green;
    } else if (congestion < 70) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}