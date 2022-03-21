import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String weatherData = response.body;

        return weatherData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      // TODO
      print(e);
    }
  }
}
