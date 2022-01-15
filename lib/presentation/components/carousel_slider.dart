import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/models/home_data_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final HomeModel homemodel;
  const CustomCarouselSlider({Key? key, required this.homemodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ...homemodel.data.banners
            .map((e) => Image(image: NetworkImage(e.image)))
      ],
      options: CarouselOptions(
        height: 250,
        initialPage: 0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
