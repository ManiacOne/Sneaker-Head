import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_head/size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages(
      {Key? key, required this.selectedImage, required this.snapshot})
      : super(key: key);

  final int selectedImage;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0 * SizeConfig.heightMultiplier,
      width: 100.0 * SizeConfig.widthMultiplier,
      child: Column(
        children: [
          CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                height: 30.0 * SizeConfig.heightMultiplier,
                onPageChanged: (index, reason) {
                  _currentIndex = index;
                  setState(() {});
                },
              ),
              itemCount: widget.snapshot.data?.docs[0]["image"].length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return SizedBox(
                  width: 100.0 * SizeConfig.widthMultiplier,
                  child: Image.network(
                      widget.snapshot.data?.docs[0]["image"][itemIndex],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Icon(
                      Icons.broken_image,
                      size: 3.5 * SizeConfig.heightMultiplier,
                      color: Colors.black38,
                    ));
                  }, loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black45,
                        backgroundColor: Colors.grey,
                        strokeWidth: 1.5 * SizeConfig.widthMultiplier,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }),
                );
              }),
          DotsIndicator(
            dotsCount: widget.snapshot.data?.docs[0]["image"].length,
            position: _currentIndex.toDouble(),
            decorator: const DotsDecorator(
              color: Colors.black87, // Inactive color
              activeColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
