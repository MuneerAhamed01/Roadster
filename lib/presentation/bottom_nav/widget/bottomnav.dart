import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:road_ster/domain/core/colors.dart';

import '../../../application/bottomnavigation/bottomnavigation_cubit.dart';

class BottomNavBarCustomized extends StatelessWidget {
  const BottomNavBarCustomized({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);
  final bool state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BottomNavigationBar(
              backgroundColor: colorPalette2,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Color.fromARGB(255, 2, 1, 1),
                    icon: Icon(
                      FontAwesomeIcons.house,
                      size: 20,
                    ),
                    label: "label"),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.car,
                    size: 20,
                  ),
                  label: "Home",
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.list,
                    size: 20,
                  ),
                  label: "home@",
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.gear,
                    size: 20,
                  ),
                  label: "home@",
                  backgroundColor: Colors.white,
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.black,
              currentIndex: index,
              onTap: (index) {
                context.read<BottomnavigationCubit>().onChangingIndex(index);
              },
            )),
      ),
    );
  }
}
