import 'package:animeflv/globals.dart';
import 'package:http/http.dart' as http;

class StreamTapeResolver {
  String regex = r'''ById\('.+?=\s*(["']\/\/[^;<]+)''';
  Future<List> resolveUrl(String url) async {
    Map<String, String> headers = {
      'User-Agent': FF_USER_AGENT,
      'Referer': 'https://streamtape.com/',
    };
    try {
      final res = await http.Client().get(Uri.parse(url), headers: headers);
      final src = RegExp(regex, caseSensitive: false).allMatches(res.body).last;

      String srcUrl = '';
      final parts = src[src.groupCount]!.replaceAll("'", '"').split('+');
      for (var part in parts) {
        String p1 = RegExp(r'"([^"]*)', caseSensitive: false)
            .firstMatch(part)!
            .group(1)
            .toString();
        int p2 = 0;
        if (part.contains('substring')) {
          final subs = RegExp(r'substring\((\d+)\)', caseSensitive: false)
              .allMatches(part);
          for (var sub in subs) {
            p2 += int.parse(sub.group(1).toString());
          }
        }
        srcUrl += p1.substring(p2);
      }
      srcUrl += '&stream=1';
      srcUrl = srcUrl.startsWith('//') ? 'https:$srcUrl' : srcUrl;
      return [srcUrl];
    } catch (_) {}
    return [];
  }
}
