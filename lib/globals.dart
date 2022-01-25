import 'package:quiver/iterables.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';

// function to parse the downloads table to a map
List parseTable(Bs4Element? table) {
  final columns = table
      ?.find('thead')
      ?.find('tr')
      ?.findAll('th')
      .map((x) => x.string)
      .toList();
  final rows = [];
  for (var row in table!.find('tbody')!.findAll('tr')) {
    final values = row.findAll('td');

    if (values.length != columns?.length)
      throw Exception('Values size does not match column size.');

    rows.add({
      for (var hx in zip([columns!, values])) hx[0]: hx[1]
    });
  }
  return rows;
}

// base urls we'll use
const SEARCH_URL = 'https://animeflv.net/browse?q=';
const BASE_URL = 'https://animeflv.net';
const BROWSE_URL = 'https://animeflv.net/browse?';
const ANIME_VIDEO_URL = 'https://animeflv.net/ver/';
const BASE_EPISODE_IMG_URL = 'https://cdn.animeflv.net/screenshots/';
const IE_USER_AGENT =
    'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko';
const FF_USER_AGENT =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0';
const OPERA_USER_AGENT =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36 OPR/67.0.3575.97';
const IOS_USER_AGENT =
    'Mozilla/5.0 (iPhone; CPU iPhone OS 13_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.5 Mobile/15E148 Safari/604.1';
const ANDROID_USER_AGENT =
    'Mozilla/5.0 (Linux; Android 9; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Mobile Safari/537.36';
const EDGE_USER_AGENT =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363';
const CHROME_USER_AGENT =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4136.7 Safari/537.36';
const SAFARI_USER_AGENT =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15';
