import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/image_response.dart';

class ImageService extends ChangeNotifier {
  final String _apiKey = 'a0523d51b3e71736a55983de6f20b164';
  final String _baseUrl = 'api.flickr.com';

  Future<List<String>> buscarFotos(String ciudad) async {
    final uri = Uri.https(_baseUrl, '/services/rest/');

    final params = {
      'method': 'flickr.photos.search',
      'api_key': _apiKey,
      'text': ciudad,
      'format': 'json',
      'nojsoncallback': '1',
      'per_page': '10' // Cantidad de fotos a obtener
    };

    // final response = await http.get(url.replace(queryParameters: params));

    // if (response.statusCode == 200) {
    // final data = imageResponseFromJson(response.body);

    //   if (data['photos'] != null && data['photos']['photo'] != null) {
    //     final photos = data['photos']['photo'] as List<dynamic>;
    //     return photos
    //         .map((photo) =>
    //             'https://live.staticflickr.com/${photo['server']}/${photo['id']}_${photo['secret']}.jpg')
    //         .toList()
    //         .cast<String>();
    //   }
    return [];
  }

  // return [];
// }
}
