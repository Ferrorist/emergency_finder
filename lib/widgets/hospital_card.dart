import 'package:emergency_finder/screens/details.dart';
import 'package:flutter/material.dart';
import 'congestion_circle.dart';
import '../models/hospital_model.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key, required this.hospital});
  final HospitalModel hospital;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => details(
                latitude: hospital.latitude,
                longitude: hospital.longitude,
                phonenumber: hospital.phonenumber,
                name: hospital.name,
                address: hospital.address,
                department: hospital.department,
                congestion: hospital.congestion,
                major: hospital.major,
                fromtodistance: hospital.fromtodistance))
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1.8,
                offset: const Offset(4, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: NumberCircle(congestion: hospital.congestion)),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hospital.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          hospital.major ?? '당직 정보 없습니다.',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hospital.address,
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${hospital.fromtodistance!}km' ?? '계산중입니다.',
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
    );
  }
}
