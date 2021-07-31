import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:imageria/src/models/save_user_response_model.dart';
import 'package:imageria/src/constants/api_constants.dart';

class UserRepository {
  Dio _dio = new Dio();

  Future<SaveUserResponseModel> saveUser({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String phoneNumber,
    @required File image,
    @required String imageName,
  }) async {
    SaveUserResponseModel responseModel;
    var formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      "phone": phoneNumber,
      "user_image":
          await MultipartFile.fromFile(image.path, filename: imageName),
    });
    try {
      var response = await _dio.post('$baseUrl/savedata.php', data: formData);
      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        if (data["status"] == "success") {
          responseModel = SaveUserResponseModel(
              status: data["status"], message: data["message"]);
          return responseModel;
        } else {
          responseModel = SaveUserResponseModel(
              status: data["status"], message: data["message"]);
          return responseModel;
        }
      } else {
        {
          responseModel = SaveUserResponseModel(
              status: "failed",
              message: "some error occured, Please try again later");
          return responseModel;
        }
      }
    } catch (e) {
      responseModel = SaveUserResponseModel(
          status: "failed",
          message: "some error occured, Please try again later");
      return responseModel;
    }
  }
}
