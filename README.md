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

# This package is an API for the anime website animeflv.net which has spanish sub anime.

## Features

* Search for anime
* Fetch anime info
* Fetch episode servers
* Fetch episode download links

## Usage

### Import the package and create a AnimeFlv object
```dart
import 'package:animeflv/animeflv.dart';

var animeflv = AnimeFlv();
```
### Search for an anime, i.e. horimiya
```dart
var search_result = await animeflv.search(query: 'horimiya');
print(search_result);
```
Output
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
var horimiya = search_result[0];
var animeinfo = await animeflv.getAnimeInfo(id: horimiya['id']);
print(animeinfo);
```
Output:
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
### Get the servers for an anime episode. i.e. 1st episode of horimiya (Not all servers will have same atributes, but they'll all have server and either url or code)
```dart
var horimiyaFirstEpisode = horimiya['episodes'][0];
var servers = await animeflv.getVideoServers(id: horimiyaFirstEpisode['id']);
print(servers)
```
OUTPUT:
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
var downloadLinks = await animeflv.DownloadLinksByEpisode(id: horimiyaFirstEpisode['id']);
print(downloadLinks)
```
OUTPUT:
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