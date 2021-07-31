import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imageria/src/constants/constants.dart';
import 'package:imageria/src/models/image_model.dart';
import 'package:imageria/src/providers/connectivity_provider.dart';
import 'package:imageria/src/providers/images_provider.dart';
import 'package:imageria/src/views/detail_screen.dart';
import 'package:imageria/src/widgets/image_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ImageModel> _imageList = [];
  int offset = 0;
  @override
  void initState() {
    final imagesProvider = Provider.of<ImagesProvider>(context, listen: false);
    imagesProvider.loadImages(offset: offset).then((imgList) {
      setState(() {
        _imageList = imgList;
      });
    });
    super.initState();
  }

  bool isInternet = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    connectivityProvider.checkInternet().then((internet) {
      isInternet = internet;
      setState(() {});
    });

    final imagesProvider = Provider.of<ImagesProvider>(
      context,
    );
    return Scaffold(
        body: isInternet
            ? imagesProvider.getisLoading() == false
                ? Container(
                    child: ListView.builder(
                        itemCount: _imageList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                imgUrl:
                                                    _imageList[index].xtImage,
                                              )),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: height * 0.02,
                                          horizontal: width * 0.02),
                                      child: ImageCard(
                                          imgUrl: _imageList[index].xtImage))),
                              index == _imageList.length - 1
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            imagesProvider
                                                .loadImages(offset: offset + 1)
                                                .then((imgList) {
                                              for (var item in imgList) {
                                                _imageList.add(item);
                                              }
                                              setState(() {});
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: height * 0.05),
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.15),
                                            decoration: BoxDecoration(
                                                gradient: buttonBgGradient,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 3,
                                                      color: Colors.grey,
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 2)
                                                ]),
                                            child: Center(
                                                child: Text(
                                              "Click Here To Load More",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          );
                        }),
                  )
                : Container(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                    return Container(
                       margin: EdgeInsets.symmetric(
                                          vertical: height * 0.02,
                                          horizontal: width * 0.02),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        enabled: true,
                        child: Container(
                          width: width,
                          height: height * 0.3,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }))
            : Container(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        Icons.info,
                        size: 60,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "No internet found.",
                      textAlign: TextAlign.center,
                    )
                  ],
                )));
  }
}
