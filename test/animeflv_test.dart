import 'package:animeflv/animeflv.dart';

void main() async {
  print(await AnimeFlv()
      .getAnimeInfo('anime/kyoukai-no-kanata-movie-ill-be-here-mirai-hen'));
}
