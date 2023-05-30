import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MyGeocoder {
  Future<LatLng> _searchPlaces(String address) async {
    List<dynamic> places = [];
    const String apiKey = '83d2d7dcb4964d69b16ddc0a5e88abdc';
    final String url =
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=$address';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'KakaoAK $apiKey'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      places = data['documents'];
      LatLng position =
          LatLng(double.parse(places[0]['x']), double.parse(places[0]['y']));
      return position;
    } else {
      print('Failed to load places: ${response.statusCode}');
      return const LatLng(0, 0);
    }
  }
}
