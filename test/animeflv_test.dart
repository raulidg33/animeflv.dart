import 'package:animeflv/animeflv.dart';

void main() async {
  print((await AnimeFlv().getAnimeInfo('anime/kimetsu-no-yaiba-yuukakuhen'))['relatedAnime']);
}
