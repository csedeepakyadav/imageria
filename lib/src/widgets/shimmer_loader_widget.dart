import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderWidget extends StatefulWidget {
  const ShimmerLoaderWidget({ Key? key }) : super(key: key);

  @override
  _ShimmerLoaderWidgetState createState() => _ShimmerLoaderWidgetState();
}

class _ShimmerLoaderWidgetState extends State<ShimmerLoaderWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Container(
                          width: width,
                          height: height * 0.3,
                          color: Colors.white,
                        ),
                      );
  }
}