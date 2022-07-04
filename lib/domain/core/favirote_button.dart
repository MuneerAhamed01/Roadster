import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:road_ster/domain/core/colors.dart';

class IconOfDelete extends StatelessWidget {
  const IconOfDelete({
    Key? key,
    required this.id,
    required this.imageName,
  }) : super(key: key);
  final String id;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight.add(const Alignment(-0.1, 0)),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 2,
                  blurStyle: BlurStyle.normal,
                  offset: Offset.fromDirection(2, 3))
            ],
          ),
          child: const CircleAvatar(
            radius: 15,
            backgroundColor: colorPalette1,
            child: Icon(
              FontAwesomeIcons.heartCirclePlus,
              size: 14,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
