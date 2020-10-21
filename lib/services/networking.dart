import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  final Map<String,dynamic> map;

  NetworkHelper({this.url,this.map});

  Future getData() async {
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      // print(response.body);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
