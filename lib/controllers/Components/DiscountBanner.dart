import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data_from_api = Xeatscubit.getposters;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: data_from_api.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return Container(
              child: Image(
                image: NetworkImage(
                  'https://www.x-eats.com' +
                      data_from_api[index]['background_image'],
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            initialPage: 2,
          ),
        )
      ],
    );
  }
}
