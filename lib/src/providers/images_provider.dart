import 'package:flutter/material.dart';
import 'package:imageria/src/models/image_model.dart';
import 'package:imageria/src/repositories/image_repository.dart';

class ImagesProvider with ChangeNotifier {
  ImageRepository imageRepository = new ImageRepository();

  List<ImageModel> _imagesList = [];

  getImageList() => _imagesList;

  bool isLoading = true;
  getisLoading() => isLoading;
  bool hasError = false;
  getHasError() => hasError;

  Future<List<ImageModel>> loadImages({@required int offset}) async {
    await imageRepository.fetchImages(offset: offset).then((imageList) {
      if (imageList == []) {
        hasError = true;
        isLoading = false;
        notifyListeners();
      } else {
        _imagesList = imageList;
        hasError = false;
        isLoading = false;
        notifyListeners();
      }
    }).catchError((onError) {
      hasError = true;
      isLoading = false;
      notifyListeners();
    });
    return _imagesList;
  }
}
