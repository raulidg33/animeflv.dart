import 'package:animeflv/animeflv.dart';
import 'dart:convert';

void main() async {
  // Initialize instance of AnimeFlv
  var animeflv = AnimeFlv();

  // get last episodes uploaded to animeflv
  var lastEpisodes = await animeflv.getLastEpisodes();
  print('\nLast Episodes: \n$lastEpisodes\n');

  // get last animes uploaded to animeflv
  var lastAnimes = await animeflv.getLastAddedAnimes();
  print('\nLast Animes: \n$lastAnimes\n');

  // get on air animes on animeflv
  var airingAnimes = await animeflv.getAiringAnimes();
  print('\nOn air animes: \n$airingAnimes\n');

  // Search with query horimiya
  var searchResult = await animeflv.search('horimiya');
  print('\nSearch results for horimiya: \n$searchResult\n');

  // save first result as horimiya
  var horimiya = searchResult[0];

  // get the info of the anime horimiya
  var horimiyaInfo = await animeflv.getAnimeInfo(horimiya['id']);
  print('\nInfo of horimiya: \n$horimiyaInfo\n');

  // save first epidose of horimiya as horimiyaFirstEpisode
  var horimiyaFirstEpisode = horimiyaInfo['episodes'][0];

  // get the servers of the first episode of horimiya
  var servers = await animeflv.getVideoServers(horimiyaFirstEpisode['id']);
  print('\nServers found: \n$servers\n');

  // get the download links of the first episode of horimiya
  var downloadLinks =
      await animeflv.downloadLinksByEpisodeId(horimiyaFirstEpisode['id']);
  print('\nDownload links: \n$downloadLinks\n');
}
