import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/application/user_registration/user_registration_cubit.dart';
import 'package:road_ster/domain/core/fonts.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
import 'package:road_ster/presentation/settings/settings_screen.dart';

import '../../../../application/image_picking/image_picking_cubit.dart';
import '../../../../domain/core/asset_images.dart';
import '../../../../domain/core/sizedboxes.dart';
import '../../../../domain/core/widgets/back_buttton.dart';
import '../../../../domain/core/widgets/image_picker.dart';
import '../../../../domain/models/users_datas.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key, required this.userData, required this.image})
      : super(key: key);
  final GetUsersDetails userData;
  final String? image;

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _gendercontroller = TextEditingController();
  final TextEditingController _districtcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _namecontroller.text = widget.userData.name;
    _phonecontroller.text = widget.userData.phone.toString();
    _gendercontroller.text =
        widget.userData.gender == GenderModel.MALE ? "Male" : "Female";
    _agecontroller.text = widget.userData.age.toString();
    _districtcontroller.text = widget.userData.district;
    _addresscontroller.text = widget.userData.address;
    _emailcontroller.text = widget.userData.email;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ImagePickingCubit(),
          ),
          BlocProvider(
            create: (context) => UserRegistrationCubit(),
          ),
        ],
        child: Scaffold(
            body: BlocListener<UserRegistrationCubit, UserRegistrationState>(
          listener: (context, state) {
            if (state is UserRegistrationOnprosess) {
              Get.defaultDialog(
                  title: "",
                  content: Lottie.asset(ImagesStrings.loadingPrimary,
                      width: 100, height: 100));
            } else if (state is UserRegistrationOnsuccess) {
              print("object");
              Get.back();
              Get.back();
            }
          },
          child: SafeArea(
            child: ListView(
              children: [
                const CustomizedBackButton(),
                h30,
                _updateImage(widget.image!),
                h20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        _textfieldUpdate(
                            validator: (p0) =>
                                ValidationTextField.nameValidation(p0),
                            controller: _namecontroller,
                            label: "Name",
                            icon: const Icon(FontAwesomeIcons.user)),
                        h20,
                        _textfieldUpdate(
                            validator: (p0) =>
                                ValidationTextField.emailValidations(p0),
                            controller: _emailcontroller,
                            label: "Email",
                            icon: const Icon(FontAwesomeIcons.user)),
                        h20,
                        _textfieldUpdate(
                            inputType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (p0) =>
                                ValidationTextField.phoneNoValidation(p0),
                            controller: _phonecontroller,
                            label: "Phone No",
                            icon: const Icon(FontAwesomeIcons.phone)),
                        h20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: _textfieldUpdate(
                                  controller: _gendercontroller,
                                  label: "Gender",
                                  icon: const Icon(FontAwesomeIcons.person)),
                            ),
                            SizedBox(
                              width: 150,
                              child: _textfieldUpdate(
                                  inputType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: _agecontroller,
                                  label: "Age",
                                  icon: const Icon(FontAwesomeIcons.user)),
                            ),
                          ],
                        ),
                        h20,
                        _textfieldUpdate(
                            validator: (p0) =>
                                ValidationTextField.locationValidation(p0,
                                    value: 3),
                            controller: _districtcontroller,
                            label: "District",
                            icon: const Icon(
                                FontAwesomeIcons.locationCrosshairs)),
                        h20,
                        _textfieldUpdate(
                            validator: (p0) =>
                                ValidationTextField.locationValidation(p0,
                                    value: 10),
                            controller: _addresscontroller,
                            label: "Address",
                            icon: const Icon(FontAwesomeIcons.locationArrow)),
                      ],
                    ),
                  ),
                ),
                h30,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 40,
                    // width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: BlocBuilder<ImagePickingCubit, ImagePickingState>(
                        builder: (context, state) {
                      return MaterialButton(
                        onPressed: () {
                          // print("updated.....");
                          if (_formkey.currentState!.validate()) {
                            context
                                .read<UserRegistrationCubit>()
                                .registerNewAccount(
                                    name: _namecontroller.text,
                                    fileImage: state is ImagePickingOnDone
                                        ? state.fileImage
                                        : null,
                                    email: _emailcontroller.text,
                                    gender: _gendercontroller.text,
                                    address: _addresscontroller.text,
                                    district: _districtcontroller.text,
                                    password: "",
                                    age: _agecontroller.text,
                                    profile: Profile.updating,
                                    phone: int.parse(_phonecontroller.text));
                          }
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                  ),
                ),
                h30
              ],
            ),
          ),
        )));
  }

  Widget _updateImage(String image) {
    return BlocBuilder<ImagePickingCubit, ImagePickingState>(
        builder: (context, state) {
      return CircleAvatar(
        radius: 90.r,
        backgroundColor: Colors.grey[300],
        backgroundImage: state is ImagePickingOnDone
            ? FileImage(File(state.fileImage.path))
            : image.isNotEmpty
                ? NetworkImage(image) as ImageProvider<Object>
                : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (image.isEmpty)
              const Icon(
                FontAwesomeIcons.user,
                size: 100,
                color: Colors.grey,
              ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(BlocProvider.value(
                    value: BlocProvider.of<ImagePickingCubit>(context),
                    child: const ImagePickingWidget()));
              },
              child: Container(
                width: 60,
                color: Colors.black.withOpacity(0.2),
                height: 40,
                child: const Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  TextFormField _textfieldUpdate(
      {required String label,
      required Icon icon,
      String? Function(String?)? validator,
      TextInputType? inputType,
      bool? visible,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController? controller,
      Widget? suffix}) {
    return TextFormField(
      inputFormatters: inputFormatters,
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
        border: _underlineBorderColor(),
        enabledBorder: _underlineBorderColor(),
        focusedBorder: _underlineBorderColor(),
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

  UnderlineInputBorder _underlineBorderColor() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black));
  }
}
