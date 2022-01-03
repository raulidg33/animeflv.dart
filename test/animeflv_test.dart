import 'package:animeflv/animeflv.dart';

void main() async {
  final animeflv = AnimeFlv();
  final result = await animeflv.search('horimiya');
  print(result);
  var horimiya = result[0];
  final horimiyaInfo = await animeflv.getAnimeInfo(horimiya['id']);
  print(horimiyaInfo);
  var horimiyaFirstEpisode = horimiyaInfo['episodes'][0];
  final servers = await animeflv.getVideoServers(horimiyaFirstEpisode['id']);
  print(servers);
  final downloadLinks = await animeflv.downloadLinksByEpisodeId(horimiyaFirstEpisode['id']);
  print(downloadLinks);
}
