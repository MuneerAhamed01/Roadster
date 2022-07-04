import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:road_ster/presentation/home_screen/widgets/cursoal_container.dart';

import '../../../domain/core/list_for_carousel.dart';

class CostomizedCarousel extends StatelessWidget {
  const CostomizedCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 400,
          viewportFraction: 1,
          autoPlay: true,
          scrollPhysics: const NeverScrollableScrollPhysics()),
      items: List.generate(
        headText.length,
        (index) => CurouselContainer(
            image: image[index],
            headText: headText[index],
            text: smalltext[index]),
      ),
    );
  }
}