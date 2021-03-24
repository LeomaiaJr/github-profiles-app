import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String _baseURL = "https://api.github.com/users/"; //API EndPoint
  //Get data from API, based on username
  Future<dynamic> get(String url) async {
    var responseJson;
      final response = await http.get(Uri.parse(_baseURL + url));
      responseJson = response;
    return json.decode(responseJson.body.toString());
  }
}
