import 'dart:convert';
import 'package:http/http.dart' as http;

class MyGeocoder {
  void KakaoLocalAPI() {}

  void _searchPlaces(String address) async {
    const String apiKey = '83d2d7dcb4964d69b16ddc0a5e88abdc';
    final String url =
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=$address';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'KakaoAK $apiKey'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
    } else {
      print('Failed to load places: ${response.statusCode}');
    }
  }
}
