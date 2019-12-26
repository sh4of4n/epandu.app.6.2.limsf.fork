import 'dart:async';

import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:xml2json/xml2json.dart';

class Networking {
  final xml2json = Xml2Json();
  final appConfig = AppConfig();
  final customSnackbar = CustomSnackbar();
  // var body;
  String url;
  String customUrl;

  Networking({this.customUrl});

  Future getData({path}) async {
    if (customUrl != null) {
      url = customUrl;
    } else {
      url = await appConfig.getBaseUrl();
    }

    try {
      http.Response response = await http.get('$url${path ?? ""}');

      print('$url${path ?? ""}');

      if (response.statusCode == 200) {
        var convertResponse = response.body
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&#xD;', '');

        xml2json.parse(convertResponse);
        var jsonData = xml2json.toParker();
        var data = jsonDecode(jsonData);

        print(data);
        return data;
      } else if (response.statusCode == 400) {
        print(response.statusCode);
      } else if (response.statusCode == 500) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      return (e.toString());
    }
  }

  Future postData({String api, String path, body, headers}) async {
    try {
      if (customUrl != null) {
        url = customUrl;
      } else {
        url = await appConfig.getBaseUrl();
      }

      http.Response response = await http.post('$url/$api${path ?? ""}',
          body: body, headers: headers);

      print(
        '$url/$api${path ?? ""}',
      );

      // print('body: ' + body);

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

        print(data);
        return data;
      } else if (response.statusCode == 400) {
        print(response.statusCode);
      } else if (response.statusCode == 500) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } on TimeoutException catch (e) {
      return (e.toString());
    } on SocketException catch (e) {
      // Other exception
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
