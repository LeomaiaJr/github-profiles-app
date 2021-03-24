import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String _baseURL = "https://api.github.com/users/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseURL + url));
      responseJson = response;
    } on Error {
      return "";
    }
    print('api get recieved!');
    return json.decode(responseJson.body.toString());
  }
}
