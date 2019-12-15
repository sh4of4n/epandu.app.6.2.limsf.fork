import 'dart:async';

import 'package:epandu/utils/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:xml2json/xml2json.dart';

class Networking {
  final xml2json = Xml2Json();
  // var body;
  String url;
  String type;

  Networking({this.type}) {
    if (type == 'EWALLET')
      url = AppConfig.eWalletUrl();
    else if (type == 'SOS')
      url = AppConfig.sosUrl();
    else
      url = AppConfig.getBaseUrl();
  }

  Future getData({path}) async {
    try {
      http.Response response = await http
          .get('$url/${path.isNotEmpty ? path : ""}')
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        var convertResponse = response.body
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&#xD;', '');

        xml2json.parse(convertResponse);
        var jsonData = xml2json.toParker();
        var data = jsonDecode(jsonData);

        return data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return (e.toString());
    }
  }

  Future postData({String api, String path, body, headers}) async {
    try {
      http.Response response = await http
          .post('$url/$api${path ?? ""}', body: body, headers: headers)
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        var data;

        if (response.body.contains('&lt;')) {
          var convertResponse = response.body
              .replaceAll('&lt;', '<')
              .replaceAll('&gt;', '>')
              .replaceAll('&#xD;', '');

          xml2json.parse(convertResponse);
          var jsonData = xml2json.toParker();

          data = jsonDecode(jsonData);
        } else {
          data = jsonDecode(response.body);
        }

        return data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return (e.toString());
    }
  }

  Future multiPartRequest(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile(
      'picture',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: new MediaType('image', 'jpg'),
    );

    request.files.add(multipartFile);
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
