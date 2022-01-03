library animeflv;

import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'dart:convert';

import 'globals.dart';

class AnimeFlv {
  Future<List> downloadLinksByEpisodeId(String id) async {
    final res = await http.Client().get(Uri.parse('$ANIME_VIDEO_URL$id'));
    if (res.statusCode == 200) {
      final body = res.body.toString();
      final soup = BeautifulSoup(body);
      final table = soup.find('table', attrs: {'class': 'RTbl'});

      try {
        final rows = parseTable(table);
        var ret = [];

        for (var row in rows) {
          if (row['FORMATO'].string == 'SUB') {
            ret.add({
              'server': row['SERVIDOR'].string,
              'url': row['DESCARGAR']
                  .a['href']
                  .toString()
                  .replaceAllMapped(RegExp(r'^http[s]?://ouo.io/[A-Za-z0-9]+/[A-Za-z0-9]+\?[A-Za-z0-9]+='), (match) => '"${match.group}"')
            });
          }
        }
        for (var server in ret) {
          if (server['server'] == 'Zippyshare') {
            final resZS = await http.Client().get(Uri.parse(server['url']));
            if (resZS.statusCode == 200) {
              final body = resZS.body.toString();
              final soup = BeautifulSoup(body);

              final scripts = soup.findAll('script');
              for (var script in scripts) {
                final content = script.toString();
                if (content.contains('var n = ')) {
                  final n = int.parse(content.split('\n')[1].trim().split('var n = ')[1].split('%')[0]) % 2;
                  final b = int.parse(content.split('\n')[2].trim().split('var b = ')[1].split('%')[0]) % 3;
                  final z = int.parse(content.split('\n')[3].trim().split('var z = ')[1].split(';')[0]);
                  final title = content.split('\n')[4].trim().split('"')[3];
                  final serverurl = server['url'].replaceAll('v', 'd').replaceAll('file.html', '${n + b + z - 3}$title');
                  server['url'] = serverurl;
                }
              }
            }
          }
        }
        return ret;
      } catch (e) {}
    }
    return [];
  }

  Future<List> search(String query) async {
    final res = await http.Client().get(Uri.parse('$SEARCH_URL$query'));
    if (res.statusCode == 200) {
      final body = res.body.toString();
      final soup = BeautifulSoup(body);
      final elements = soup.findAll('article', class_: 'Anime alt B');
      var ret = [];
      for (var element in elements) {
        var id = element.find('', selector: 'div.Description a.Button')?['href'];
        try {
          ret.add({
            'id': id?.substring(1, id.length),
            'title': element.find('', selector: 'a h3')?.string,
            'poster': element.find('', selector: '.Image figure img')?['src'],
            'banner': element.find('', selector: '.Image figure img')?['src']?.replaceAll('covers', 'banners').trim(),
            'type': element.find('', selector: 'div.Description p span.Type')?.string,
            'synopsis': element.findAll('', selector: 'div.Description p')[1].string.trim(),
            'rating': element.find('', selector: 'div.Description p span.Vts')?.string,
            // 'debut': element.find('', selector: 'a span.Estreno')?.string.toLowerCase(),
          });
        } catch (e) {}
      }
      return ret;
    }
    return [];
  }

  Future<List> getVideoServers(String id) async {
    final res = await http.Client().get(Uri.parse('$ANIME_VIDEO_URL$id'));
    if (res.statusCode == 200) {
      final body = res.body.toString();
      final soup = BeautifulSoup(body);
      final scripts = soup.findAll('script');
      var servers = [];
      for (var script in scripts) {
        final content = script.toString();
        if (content.contains('var videos = {')) {
          final videos = content.split('var videos = ')[1].split(';')[0];
          final data = json.decode(videos);
          if (data.containsKey('SUB')) servers.add(data['SUB']);
        }
      }
      return servers[0];
    }
    return [];
  }

  Future<Map> getAnimeInfo(String id) async {
    final animeEpisodesInfo = await _getAnimeEpisodesInfo(id);

    final episodes = animeEpisodesInfo[0]!;
    final genres = animeEpisodesInfo[1]!;
    final extraInfo = animeEpisodesInfo[2]!;

    return {
      'id': id,
      'title': extraInfo['title'],
      'poster': extraInfo['poster'],
      'banner': extraInfo['banner'],
      'synopsis': extraInfo['synopsis'],
      'rating': extraInfo['rating'],
      'debut': extraInfo['debut'],
      'type': extraInfo['type'],
      'genres': genres,
      'episodes': List.from(episodes.reversed),
    };
  }

  Future<List> _getAnimeEpisodesInfo(String id) async {
    final res = await http.Client().get(Uri.parse('$BASE_URL/$id'));
    if (res.statusCode == 200) {
      final body = res.body.toString();
      final soup = BeautifulSoup(body);

      var extraInfo = {
        'title': soup.find('', selector: 'h1.Title')?.string,
        'poster': '$BASE_URL${soup.find("", selector: "div.Image figure img")?["src"]}',
        'synopsis': soup.find('', selector: 'div.Description p')?.string.trim(),
        'rating': soup.find('', selector: 'span#votes_prmd')?.string,
        'debut': soup.find('', selector: 'p.AnmStts')?.string,
        'type': soup.find('', selector: 'span.Type')?.string,
      };
      extraInfo['banner'] = extraInfo['poster']?.replaceAll('covers', 'banners');
      var genres = [];
      final elements = soup.findAll('', selector: '.Nvgnrs a');
      for (var element in elements) {
        if (element['href']!.contains('=')) genres.add(element['href']?.split('=')[1]);
      }
      var infoIds = [];
      var episodesData = [];
      var episodes = [];

      try {
        for (var script in soup.findAll('script')) {
          final contents = script.toString();
          if (contents.contains('var anime_info')) {
            final animeInfo = contents.split('var anime_info = ')[1].split(';')[0];
            infoIds.add(json.decode(animeInfo));
          }
          if (contents.contains('var episodes = [')) {
            final data = contents.split('var episodes = ')[1].split(';')[0];
            for (var episodeData in json.decode(data)) {
              episodesData.add([episodeData[0], episodeData[1]]);
            }
          }
        }
        final animeId = infoIds[0][2];
        for (var episodeData in episodesData) {
          episodes.add({
            'episode': episodeData[0],
            'id': '$animeId-${episodeData[0]}',
            'imagePreview': '$BASE_EPISODE_IMG_URL${infoIds[0][0]}/${episodeData[0]}/th_3.jpg',
          });
        }
      } catch (e) {}
      return [episodes, genres, extraInfo];
    }
    return [];
  }
}
