import 'package:quiver/iterables.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';

List parseTable(Bs4Element? table) {
  final columns = table?.find('thead')?.find('tr')?.findAll('th').map((x) => x.string).toList();
  final rows = [];
  for (var row in table!.find('tbody')!.findAll('tr')) {
    final values = row.findAll('td');

    if (values.length != columns?.length) throw Exception('Values size does not match column size.');

    rows.add({
      for (var hx in zip([columns!, values])) hx[0]: hx[1]
    });
  }
  return rows;
}

const SEARCH_URL = 'https://animeflv.net/browse?q=';
const BASE_URL = 'https://animeflv.net';
const BROWSE_URL = 'https://animeflv.net/browse?';
const ANIME_VIDEO_URL = 'https://animeflv.net/ver/';
const BASE_EPISODE_IMG_URL = 'https://cdn.animeflv.net/screenshots/';
