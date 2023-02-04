
import 'dart:convert';

import 'package:chat_app/models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<ImageModel>> getNetworkImages() async {
    var endpoint = Uri.parse('https://pixelford.com/api2/images');
    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;
      final List<ImageModel> networkImages = decodedList.map((listIem) {
        return ImageModel.fromJson(listIem);
      }).toList();

      return networkImages;
    }

    throw Exception('Call to API failed!');
  }
}