import 'package:flutter/material.dart';

import '../models/hospital_model.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key, required this.hospital});
  final HospitalModel hospital;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.local_hospital_outlined,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital.name,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  hospital.address,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
