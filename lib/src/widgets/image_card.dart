import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imageria/src/widgets/shimmer_loader_widget.dart';
import 'dart:ui' as ui;
import 'package:shimmer/shimmer.dart';

class ImageCard extends StatelessWidget {
  final String? imgUrl;
  ImageCard({@required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Image image = new Image.network(imgUrl!);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
      completer.complete(info.image);
    }));

    return Container(
      child: FutureBuilder<ui.Image>(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: double.parse(snapshot.data!.width.toString()) /
                  double.parse(snapshot.data!.height.toString()),
              child: Image.network(
                imgUrl!,
              ),
            );
          } else {
          return ShimmerLoaderWidget();
            }
        },
      ),
    );
  }
}
