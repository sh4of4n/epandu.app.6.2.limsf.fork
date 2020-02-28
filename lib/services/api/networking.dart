import 'dart:async';

import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:xml2json/xml2json.dart';

import '../response.dart';

class Networking {
  final xml2json = Xml2Json();
  final appConfig = AppConfig();
  final customSnackbar = CustomSnackbar();
  final wsUrlBox = Hive.box('ws_url');
  // var body;
  String url;
  String customUrl;

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  Networking({this.customUrl});

  Future<Response> getData({method, param, headers}) async {
    if (customUrl != null) {
      url = customUrl;
    } else {
      url = await wsUrlBox.get('wsUrl');
    }

    String parsedUrl;

    if (url.contains('https')) {
      parsedUrl = url.replaceAll('https://', '');
    } else if (url.contains('http')) {
      parsedUrl = url.replaceAll('http://', '');
    }

    List<String> authority = parsedUrl.split('/');

    String extraUri1 = '';

    if (authority.length >= 5) {
      extraUri1 = '${authority[4]}/';
    }

    String unencodedpath =
        '/${authority[1]}/${authority[2]}/${authority[3]}/$extraUri1$method';

    Uri uri = Uri.http(authority[0], unencodedpath, param);

    try {
      http.Response response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 30));

      print(uri);

      if (response.statusCode == 200) {
        var convertResponse = response.body
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&#xD;', '')
            .replaceAll(r"\'", "'");

        xml2json.parse(convertResponse);
        var jsonData = xml2json.toParker();
        var data = jsonDecode(jsonData);

        print(data);
        return Response(true, data: data);
      } else {
        String message = response.body;
        String trimmedMessage = removeAllHtmlTags(message);
        String parsedMessage = trimmedMessage
            .replaceAll('[BLException]', '')
            .replaceAll('&#xD;', '')
            .replaceAll(r'"', '')
            .replaceAll('\n', '');

        print(response.statusCode);

        return Response(
          false,
          message: parsedMessage,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on SocketException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    }
  }

  Future<Response> getRequest({path}) async {
    if (customUrl != null) {
      url = customUrl;
    } else {
      url = await wsUrlBox.get('wsUrl');
    }

    try {
      http.Response response = await http
          .get('$url${path ?? ""}')
          .timeout(const Duration(seconds: 30));

      print('$url${path ?? ""}');

      if (response.statusCode == 200) {
        var convertResponse = response.body
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&#xD;', '')
            .replaceAll(r"\'", "'");

        xml2json.parse(convertResponse);
        var jsonData = xml2json.toParker();
        var data = jsonDecode(jsonData);

        print(data);
        return Response(true, data: data);
      } else {
        String message = response.body;
        String trimmedMessage = removeAllHtmlTags(message);
        String parsedMessage = trimmedMessage
            .replaceAll('[BLException]', '')
            .replaceAll('&#xD;', '')
            .replaceAll(r'"', '')
            .replaceAll('\n', '');

        print(response.statusCode);

        return Response(
          false,
          message: parsedMessage,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on SocketException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    }
  }

  Future<Response> postData({String api, String path, body, headers}) async {
    try {
      if (customUrl != null) {
        url = customUrl;
      } else {
        url = await wsUrlBox.get('wsUrl');
      }

      http.Response response = await http
          .post('$url$api${path ?? ""}', body: body, headers: headers)
          .timeout(const Duration(seconds: 30));

      print('$url$api${path ?? ""}');

      print('body: ' + body);

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
        return Response(true, data: data);
      } else {
        String message = response.body
            .replaceAll('[BLException]', '')
            .replaceAll('&#xD;', '')
            .replaceAll(r'"', '')
            .replaceAll('\n', '');

        print(response.statusCode);

        return Response(
          false,
          message: message,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on SocketException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: e.toString());
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
