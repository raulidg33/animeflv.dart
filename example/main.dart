import 'package:animeflv/animeflv.dart';

void main() async {
  // Initialize instance of AnimeFlv
  var animeflv = AnimeFlv();

  // Search with query horimiya
  var search_result = await animeflv.search('horimiya');
  print(search_result);

  // save first result as horimiya
  var horimiya = search_result[0];

  // get the info of the anime horimiya
  var horimiyaInfo = await animeflv.getAnimeInfo(horimiya['id']);
  print(horimiyaInfo);

  // save first epidose of horimiya as horimiyaFirstEpisode
  var horimiyaFirstEpisode = horimiyaInfo['episodes'][0];

  // get the servers of the first episode of horimiya
  var servers = await animeflv.getVideoServers(horimiyaFirstEpisode['id']);
  print(servers);

  // get the download links of the first episode of horimiya
  var downloadLinks =
      await animeflv.downloadLinksByEpisodeId(horimiyaFirstEpisode['id']);
  print(downloadLinks);
}
