import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<ImageModel>> getNetworkImages() async {
    try {
      var endpoint = Uri.parse('https://pixelford.com/api2/images');
      final response = await http.get(endpoint);

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;
        final List<ImageModel> networkImages = decodedList.map((listIem) {
          return ImageModel.fromJson(listIem);
        }).toList();

        return networkImages;
      }
      throw Exception('Something went wrong');
    } on SocketException {
      throw Exception('Internet connection failed.');
    } on HttpException {
      throw Exception('Failed to retrieve image from the API.');
    } on FormatException {
      throw Exception('Bad response format.');
    } catch (e) {
      print(e);
      throw Exception('Something went wrong');
    }
  }
}
