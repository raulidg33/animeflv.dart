<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# AnimeFLV dart API

### An animeflv.net api that allows you to retrieve different data from the animeflv catalog, and use it inside your own app or code using dart.

## Features

* Get last added episodes
* Get last added animes
* Get on air animes
* Search anime
* Get anime info (includes episodes)
* Get episode servers
* Get episode download links

## Usage
The available functions return either a Map or a List of Maps.
###      
### Import the package and create an AnimeFlv instance
```dart
import 'package:animeflv/animeflv.dart';

// Initialize instance of AnimeFlv
var animeflv = AnimeFlv();
```
### Get last added episodes
```dart
// get last episodes uploaded to animeflv
var lastEpisodes = await animeflv.getLastEpisodes();
```
lastEpisodes:
```json
[
    {
        "anime":"Saihate no Paladin",
        "episode":"12","id":"/saihate-no-paladin-12",
        "imagePreview":"https://animeflv.net/uploads/animes/thumbs/3541.jpg"
    },
    {
        "anime":"Kimetsu no Yaiba: Yuukaku-hen",
        "episode":"5",
        "id":"/kimetsu-no-yaiba-yuukakuhen-5",
        "imagePreview":"https://animeflv.net/uploads/animes/thumbs/3554.jpg"
    },

        "..."
    {
        "anime":"86 2nd Season",
        "episode":"10",
        "id":"/86-2nd-season-10",
        "imagePreview":"https://animeflv.net/uploads/animes/thumbs/3520.jpg"
    }
]

```
### Get last added animes
```dart
// get last animes uploaded to animeflv
var lastAnimes = await animeflv.getLastAddedAnimes();
```
lastAnimes:
```json
[
    {
        "id":"anime/mahouka-koukou-no-rettousei-tsuiokuhen",
        "title":"Mahouka Koukou no Rettousei: Tsuioku-hen",
        "poster":"/uploads/animes/covers/3556.jpg",
        "banner":"/uploads/animes/banners/3556.jpg",
        "type":"Especial",
        "synopsis":"Mirando a Miyuki y Tatsuya ahora, podría ser difícil imaginarlos como algo más que hermanos cariñosos. Pero no siempre fue así… Hace tres años, Miyuki siempre se sentía incómoda con su hermano mayor. El resto de la familia lo trataba como a un simple sirviente, a pesar de que era el guardi...",
        "rating":"4.7"
    },
    {
        "id":"anime/mahoutsukai-no-yome-nishi-no-shounen-to-seiran-no-kishi",
        "title":"Mahoutsukai no Yome: Nishi no Shounen to Seiran no Kishi",
        "poster":"/uploads/animes/covers/3555.jpg",
        "banner":"/uploads/animes/banners/3555.jpg",
        "type":"OVA",
        "synopsis":"La historia original de tres partes sigue a Gabriel, un chico común que se acaba de mudar de Londres y estaba aburrido de su entorno, hasta que un día, vio una voluta de humo púrpura desde la ventana de su casa. En ese momento, persiguió apresuradamente el humo, buscando cualquier tipo de libert...",
        "rating":"4.7"
    },

        "..."

    {
        "id":"anime/shin-no-nakama-ja-nai-to-yuusha-no-party-wo-oidasareta-node-henkyou-de-slow-life-suru-koto-ni-shimas",
        "title":"Shin no Nakama ja Nai to Yuusha no Party wo Oidasareta node, Henkyou de Slow Life suru Koto ni Shima",
        "poster":"/uploads/animes/covers/3533.jpg",
        "banner":"/uploads/animes/banners/3533.jpg",
        "type":"Anime",
        "synopsis":"En un mundo de fantasía en el que una chica con la Protección Divina del héroe combate contra el Señor Demonio. En ese mundo, Red, el hermano mayor de esa chica, quien posee la Protección Divina del “Guía”, que solo le otorga un nivel inicial mayor que sus compañeros, acompañó al héroe...",
        "rating":"4.6"
    }
]
```
### Get on air anime
```dart
// get on air animes on animeflv
var onAirAnimes = await animeflv.getOnAirAnimes();
```
onAirAnimes:
```json
[
    {
        "id":"anime/one-piece-tv",
        "title":"One Piece",
        "type":"Anime"
    },
    {
        "id":"anime/detective-conan",
        "title":"Detective Conan",
        "type":"Anime"
    },

        "..."

    {
        "id":"anime/mahoutsukai-no-yome-nishi-no-shounen-to-seiran-no-kishi",
        "title":"Mahoutsukai no Yome: Nishi no Shounen to Seiran no Kishi",
        "type":"OVA"
    }
]
```
### Search for an anime, i.e. horimiya
```dart
// Search with query horimiya
var searchResult = await animeflv.search('horimiya');
```
searchResult:
```json
[
    {
        "id": "anime/horimiya", 
        "title": "Horimiya", 
        "poster": "https://animeflv.net/uploads/animes/covers/3406.jpg", 
        "banner": "https://animeflv.net/uploads/animes/banners/3406.jpg", 
        "type": "Anime", 
        "synopsis": "Aunque admirada en la escuela por su amabilidad y destreza académica, la estudiante de preparatoria Kyouko Hori ha estado escondiendo otro lado de ella. Con sus padres a menudo fuera de casa debido al trabajo, Hori tiene que cuidar de su hermano menor y hacer las tareas del hogar, sin tener tiempo para socializar fuera de la escuela. \n        Mientras t...", 
        "rating": "4.7",
    }
]
```
### Get horimiya info
```dart
// save first result as horimiya
var horimiya = searchResult[0];

// get the info of the anime horimiya
var horimiyaInfo = await animeflv.getAnimeInfo(horimiya['id']);
```
horimiyaInfo:
```json
{
    "id": "anime/horimiya", 
    "title": "Horimiya", 
    "poster": "https://animeflv.net/uploads/animes/covers/3406.jpg", 
    "banner": "https://animeflv.net/uploads/animes/banners/3406.jpg", 
    "synopsis": "Aunque admirada en la escuela por su amabilidad y destreza académica, la estudiante de preparatoria Kyouko Hori ha estado escondiendo otro lado de ella. Con sus padres a menudo fuera de casa debido al trabajo, Hori tiene que cuidar de su hermano menor y hacer las tareas del hogar, sin tener tiempo para socializar fuera de la escuela.\n    Mientras tanto, Izumi Miyamura es visto como un inquietante otaku que usa anteojos. Sin embargo, en realidad es una persona amable e inepta para estudiar. Además, tiene nueve piercings escondidos detrás de su largo cabello, y un tatuaje a lo largo de su espalda y hombro izquierdo.\n    Por pura casualidad, Hori y Miyamura se cruzan fuera de la escuela, ninguno luciendo como el otro lo esperaría. Estos polos aparentemente opuestos se convierten en amigos, compartiendo un lado que nunca le han mostrado a nadie.", 
    "rating": "4.7", 
    "debut": "Finalizado", 
    "type": "Anime", 
    "genres": ["comedia", "escolares", "recuentos-de-la-vida", "romance", "shounen"], 
    "episodes": [
        {
            "episode": "1", 
            "id": "horimiya-1", 
            "imagePreview": "https://cdn.animeflv.net/screenshots/3406/1/th_3.jpg"
        },
        {
            "episode": "2", 
            "id": "horimiya-2", 
            "imagePreview": "https://cdn.animeflv.net/screenshots/3406/2/th_3.jpg"
        }
            "..."

        {
        
            "episode": "13", 
            "id": "horimiya-13", 
            "imagePreview": "https://cdn.animeflv.net/screenshots/3406/13/th_3.jpg"
        }

    ]
}
```
### Get the servers for an anime episode. i.e. 1st episode of horimiya (Not all servers will have same attributes, but they'll all have server and either url or code)
```dart
// save first epidose of horimiya as horimiyaFirstEpisode
var horimiyaFirstEpisode = horimiyaInfo['episodes'][0];

// get the servers of the first episode of horimiya
var servers = await animeflv.getVideoServers(horimiyaFirstEpisode['id']);
```
servers:
```json

[
    {
        "server": "mega", 
        "title": "MEGA",
        "ads": 0, 
        "url": "https://mega.nz/#!hZJHHSBR!c4jM0fqL0i3tZnEYytw3M73Fvz70UtHD7c5DoReVDaM", 
        "allow_mobile": true, 
        "code": "https://mega.nz/embed#!hZJHHSBR!c4jM0fqL0i3tZnEYytw3M73Fvz70UtHD7c5DoReVDaM"
    }, 
    {
        "server": "yu", 
        "title": "YourUpload", 
        "ads": 0, 
        "allow_mobile": true, 
        "code": "https://www.yourupload.com/embed/BjjGnSUJ68q0"
    },

        "..."

    {
        "server": "Stape", 
        "url": "https://streamtape.com/v/BP4zD44wWxFydZa/"
    }
]

```
### Get the download links for an anime episode. i.e 1st episode of horimiya
```dart
// get the download links of the first episode of horimiya
var downloadLinks = await animeflv.downloadLinksByEpisodeId(horimiyaFirstEpisode['id']);
```
downloadLinks:
```json
[
    {
        "server": "MEGA", 
        "url": "https://mega.nz/#!hZJHHSBR!c4jM0fqL0i3tZnEYytw3M73Fvz70UtHD7c5DoReVDaM"
    }, 
    {
        "server": "Zippyshare", 
        "url": "https://www102.zippyshare.com/d/Qhpk3cCA/955113/3406_1.mp4"
    }, 
    {
        "server": "Stape", 
        "url": "https://streamtape.com/v/BP4zD44wWxFydZa/"
    }
]

```