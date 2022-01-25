import 'package:http/http.dart' as http;
import './helpers.dart';
import 'dart:convert';

class FembedResolver {
  Future<List> resolverUrl(webUrl) async {
    http.Client client = http.Client();
    final String host = Uri.parse(webUrl).host;
    final String mediaId = List.from(webUrl.split('/').reversed)[0];
    final Map<String, String> headers = {
      'User-Agent': randUA(),
    };
    headers['Referer'] = webUrl;
    String apiUrl = 'https://$host/api/source/$mediaId';
    final res = await client.post(Uri.parse(apiUrl), headers: headers);
    if (res.statusCode == 200) {
      final Map<String, dynamic> apiRes = json.decode(res.body);
      if (apiRes['success']) {
        return apiRes['data'];
      }
    }
    return [];
  }
}
