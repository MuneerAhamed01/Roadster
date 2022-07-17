import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
    required this.width,
    required this.height,  this.shape = BoxShape.rectangle,
  }) : super(key: key);
  final double width;
  final double height;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[350]!,
        child: Container(
          width: width,
          height: height,
          
          decoration: BoxDecoration(shape: shape,color: Colors.white,),
        ));
  }
}
