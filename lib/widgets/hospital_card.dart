import 'package:emergency_finder/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'congestion_circle.dart';
import '../models/hospital_model.dart';
import 'package:swipe_to/swipe_to.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({Key? key, required this.hospital}) : super(key: key);
  final HospitalModel hospital;
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      iconOnLeftSwipe:Icons.call,
      iconOnRightSwipe: Icons.call,
      onRightSwipe: (){
        _makePhoneCall(hospital.phonenumber);
      },
      onLeftSwipe: (){
        _makePhoneCall(hospital.phonenumber);
      },
      child:Container(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Details(
                  latitude: hospital.latitude,
                  longitude: hospital.longitude,
                  phoneNumber: hospital.phonenumber,
                  name: hospital.name,
                  address: hospital.address,
                  department: hospital.department,
                  congestion: hospital.congestion,
                  major: hospital.major,
                  fromToDistance:  hospital.fromtodistance))
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
      ),
    ),
    );

  }
  void _makePhoneCall(String phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw '전화를 걸 수 없습니다.';
    }
  }
}
