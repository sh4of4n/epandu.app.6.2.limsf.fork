import 'dart:async';
import 'package:epandu/services/repository/base_repository.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:xml2json/xml2json.dart';
import '../response.dart';

class Networking extends BaseRepo {
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

  Future<Response> getData({path}) async {
    if (customUrl != null) {
      url = customUrl;
    } else {
      url = await wsUrlBox.get('wsUrl');
    }

    try {
      http.Response response;
      // for getWsUrl
      if (url == customUrl) {
        print('$url/${path ?? ""}');

        response = await http
            .get('$url/${path ?? ""}')
            .timeout(const Duration(milliseconds: 10000));
      } else {
        print('$url/webapi/${path ?? ""}');

        response = await http
            .get('$url/webapi/${path ?? ""}')
            .timeout(const Duration(milliseconds: 30000));
      }

      if (response.statusCode == 200) {
        print(response.body);

        if (response.body == 'Valid user.' ||
            response.body == 'True' ||
            response.body == 'False' ||
            url == customUrl) return Response(true, data: response.body);

        return Response(true, data: jsonDecode(response.body));
      } else {
        String message = response.body;
        String trimmedMessage = removeAllHtmlTags(message);
        String parsedMessage = trimmedMessage
            .replaceAll('[BLException]', '')
            .replaceAll('&#xD;', '')
            .replaceAll(r'"', '')
            .replaceAll('\n', '');

        print(response.statusCode);
        print(message);

        return Response(
          false,
          message: parsedMessage,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Response(false, message: 'timeout');
    } on SocketException catch (e) {
      print(e.toString());
      return Response(false, message: 'socket');
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: 'format');
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: 'http');
    }
  }

  Future<Response> postData({String api, String path, body, headers}) async {
    try {
      if (customUrl != null) {
        url = customUrl;
      } else {
        url = await wsUrlBox.get('wsUrl');
      }

      print('$url/webapi/$api${path ?? ""}');

      print('body: ' + body);

      http.Response response = await http
          .post('$url/webapi/$api${path ?? ""}', body: body, headers: headers)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        print(response.body);

        if (response.body == 'True' || response.body == 'False')
          return Response(true, data: response.body);
        else if (response.body.startsWith('{'))
          return Response(true, data: jsonDecode(response.body));
        else
          return Response(true, data: response.body);
      } else {
        String message = response.body
            .replaceAll('[BLException]', '')
            .replaceAll('&#xD;', '')
            .replaceAll(r'"', '')
            .replaceAll('\n', '');

        print(response.statusCode);
        print(message);

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

  /* Future multiPartRequest(File imageFile) async {
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
  } */
}
