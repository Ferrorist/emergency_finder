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
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
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
                        ),
                        Text(
                          hospital.fromtodistance!.toString()+'km' ?? '계산중입니다.',

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
