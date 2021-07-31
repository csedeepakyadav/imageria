import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class ImageCard extends StatelessWidget {
  final String imgUrl;
  ImageCard({@required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Image image = new Image.network(imgUrl);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
      completer.complete(info.image);
    }));

    return Container(
      color: Colors.black,
      child: FutureBuilder<ui.Image>(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: double.parse(snapshot.data.width.toString()) /
                  double.parse(snapshot.data.height.toString()),
              child: Image.network(
                imgUrl,
              ),
            );
          } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: Container(
              width: width,
              height: height * 0.3,
              color: Colors.white,
            ),
          );
            }
        },
      ),
    );
  }
}
