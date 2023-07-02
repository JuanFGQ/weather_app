import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/image_response.dart';

class ImageService extends ChangeNotifier {
  Photo? photo;
  List _urlImages = [];

  List get urlImages => _urlImages;

  set urlImages(List value) {
    _urlImages = value;
    notifyListeners();
  }

  bool _searchText = false;

  bool get searchText => _searchText;

  set searchText(bool value) {
    _searchText = value;
    notifyListeners();
  }

  final String _apiKey = 'a0523d51b3e71736a55983de6f20b164';
  final String _baseUrl = 'api.flickr.com';
  Future<List<String>> findPhotos(String ciudad) async {
    final params = {
      'method': 'flickr.photos.search',
      'api_key': _apiKey,
      'text': '${ciudad} ciudad',
      'format': 'json',
      'sort': 'interestingness-asc',
      'nojsoncallback': '1',
      'per_page': '50'
          '' // Cantidad de fotos a obtener
    };

    final uri = Uri.https(_baseUrl, '/services/rest/', params);

    final resp = await http.get(uri);

    final imageResp = imageResponseFromJson(resp.body);

    final photos = imageResp.photos.photo;

    if (resp.statusCode == 200) {
      return photos
          .map((photo) =>
              'https://live.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}_w.jpg')
          .toList();
    }
    return [];
  }

  // return [];
// }
}
