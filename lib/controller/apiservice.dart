import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<DataModel>? getDataFromServer() async {
    DataModel? empty;
    try {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(client);
      final response = await http
          .get(Uri.parse("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad"));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);

        DataModel map = DataModel.fromJson(jsondata[0]);

        return map;
      }
    } catch (e) {
      print(e);
    }
    return empty!;
  }
}
