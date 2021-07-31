import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class ImageTofileRepository {
  Dio dio = new Dio();
  Future<File> fileFromImageUrl({@required String? imgUrl}) async {
    final response = await http.get(Uri.parse(imgUrl!));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, imgUrl.split('/').last));

   file.writeAsBytesSync(response.bodyBytes);

    return file;
  }
}
