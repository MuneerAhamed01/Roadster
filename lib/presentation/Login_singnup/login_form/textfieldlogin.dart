import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/password_visible/paswordvisible_cubit.dart';

TextFormField textfieldLogin(
    {required String label,
    required Icon icon,
    String? Function(String?)? validator,
    TextInputType? inputType,
    bool? visible,
    TextEditingController? controller,
    Widget? suffix}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validator,
    style: GoogleFonts.roboto(),
    obscureText: visible ?? false,
    cursorColor: Colors.black,
    keyboardType: inputType,
    cursorWidth: 1.w,
    cursorHeight: 23.h,
    decoration: InputDecoration(
      suffixStyle: const TextStyle(color: Colors.black),
      suffixIcon: suffix,
      border: underlineBorderColor(),
      enabledBorder: underlineBorderColor(),
      focusedBorder: underlineBorderColor(),
      fillColor: Colors.black,
      focusColor: Colors.black,
      hoverColor: Colors.black,
      labelText: label,
      alignLabelWithHint: true,
      labelStyle: GoogleFonts.roboto(color: Colors.black, fontSize: 13.sp),
      icon: Padding(padding: EdgeInsets.only(top: 20.h), child: icon),
    ),
  );
}

UnderlineInputBorder underlineBorderColor() {
  return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black));
}

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({
    Key? key,
    required this.iconData,
    required this.stateValue, required this.padding,
  }) : super(key: key);
  final IconData iconData;
  final bool stateValue;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: IconButton(
          icon: Icon(
            iconData,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () {
            context.read<PaswordvisibleCubit>().onPressed(stateValue);
          }),
    );
  }
}
