import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:imageria/src/constants/api_constants.dart';
import 'package:imageria/src/models/image_model.dart';

class ImageRepository {
  Dio _dio = new Dio();

  Future<List<ImageModel>> fetchImages({@required int? offset}) async {
    List<ImageModel> imageList = [];
    var formData =
        FormData.fromMap({'user_id': 108, 'offset': offset, 'type': "popular"});
    try {
      var response = await _dio.post('$baseUrl/getdata.php', data: formData);
      //   print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        if (data["status"] == "success") {
          for (var item in data["images"]) {
            ImageModel imageModel = new ImageModel.fromJson(item);
            imageList.add(imageModel);
          }
        }
      }
      return imageList;
    } catch (e) {
      print(e);
      return imageList;
    }
  }
}
