import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/application/user_registration/user_registration_cubit.dart';
import 'package:road_ster/application/date_picker/date_picker_cubit.dart';
import 'package:road_ster/application/get_location/location_controller_cubit.dart';
import 'package:road_ster/application/password_visible/paswordvisible_cubit.dart';
import 'package:road_ster/application/text_change/text_change_cubit.dart';
import 'package:road_ster/application/users_details/get_users_details_cubit.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/fonts.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/login_page.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/pageview_models/pageview_four.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/pageview_models/pageview_one.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/pageview_models/pageview_three.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/pageview_models/pageview_two.dart';

import '../../../application/image_picking/image_picking_cubit.dart';
import '../../../domain/core/asset_images.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  static final PageController _controller = PageController();
  static final TextEditingController dateController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController districtController =
      TextEditingController();
  static final TextEditingController addressController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController passwordConfirmController =
      TextEditingController();
  static String gender = "Male";
  static final formKeyOne = GlobalKey<FormState>();
  static final formKeyThree = GlobalKey<FormState>();
  static final formKeyTwo = GlobalKey<FormState>();
  static final formKey = GlobalKey<FormState>();
  File? fileImage;

  final focus = FocusNode();

  int onPageChange = 0;
  List<Widget> pageviewSignUp = [
    PageViewModelOne(
        emailController: emailController,
        phoneController: phoneController,
        nameController: nameController,
        formKey: formKeyOne),
    PageViewModelTwo(
      formkey: formKeyTwo,
      districtController: districtController,
      adressController: addressController,
      dateController: dateController,
      onChangedGender: (genderOf) {
        if (genderOf == Gender.Male) {
          gender = "Male";
        } else if (genderOf == Gender.Female) {
          gender = "Female";
        } else {
          gender = "others";
        }
      },
    ),
    PageViewModelthree(
      formkey: formKeyThree,
      passwordConfirmController: passwordConfirmController,
      passwordController: passwordController,
    ),
    const PageViewModelFour()
  ];
  @override
  void dispose() {
    dateController.text = '';
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    addressController.text = "";
    passwordController.text = "";
    passwordConfirmController.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DatePickerCubit()),
        BlocProvider(create: (context) => TextChangeCubit()),
        BlocProvider(create: (context) => GetUsersDetailsCubit()),
        BlocProvider(create: (context) => PaswordvisibleCubit()),
        BlocProvider(create: (context) => LocationControllerCubit()),
        BlocProvider(create: (context) => UserRegistrationCubit()),
        BlocProvider(create: (context) => ImagePickingCubit()),
      ],
      child: Builder(
        builder: (context) {
          context.read<GetUsersDetailsCubit>().getUserDetails();
          return MultiBlocListener(
            listeners: [
              BlocListener<UserRegistrationCubit, UserRegistrationState>(
                listener: (context, state) {
                  if (state is UserRegistrationOnprosess) {
                    Get.defaultDialog(
                        title: "",
                        content: Lottie.asset(ImagesStrings.loadingPrimary,
                            width: 100, height: 100));
                  } else if (state is UserRegistrationOnsuccess) {
                    Get.back();
                    Get.offAll(() => LoginPage());
                  } else if (state is UserRegistrationOnError) {
                    Get.back();
                    Get.showSnackbar(GetSnackBar(
                      title: "Something Wrong",
                      message: state.message.splitMapJoin("l"),
                    ));
                  }
                },
              ),
              BlocListener<ImagePickingCubit, ImagePickingState>(
                listener: (context, state) {
                  if (state is ImagePickingOnDone) {
                    fileImage = state.fileImage;
                  }
                },
              )
            ],
            child: Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar:
                  BlocBuilder<TextChangeCubit, TextChangeState>(
                      builder: (context, state) {
                state as TextChangeInitial;
                return Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(112, 0, 0, 0),
                              blurRadius: 6,
                              blurStyle: BlurStyle.outer)
                        ],
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    width: double.infinity,
                    height: 80.h,
                    child: Row(
                      children: [
                        // if (state.pageno != 0)
                        MaterialButton(
                          onPressed: () {
                            _controller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color:
                                state.pageno == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Row(
                            children: [
                              const Text("Already Have account?"),
                              TextButton(
                                child: const Text("Sign In"),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (state.pageno != 3) {
                              if (state.pageno == 0) {
                                if (formKeyOne.currentState!.validate()) {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              } else if (state.pageno == 1) {
                                if (formKeyTwo.currentState!.validate()) {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              } else if (state.pageno == 2) {
                                if (formKeyThree.currentState!.validate()) {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              }
                            } else {
                              context
                                  .read<UserRegistrationCubit>()
                                  .registerNewAccount(
                                    profile: Profile.adding,
                                      fileImage: fileImage,
                                      name: nameController.text,
                                      email: emailController.text,
                                      gender: gender,
                                      address: addressController.text,
                                      district: districtController.text,
                                      password: passwordController.text,
                                      age: dateController.text,
                                      phone: int.parse(phoneController.text));
                            }
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ));
              }),
              body: Form(
                key: formKey,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) {
                    FocusScope.of(context).unfocus();
                    context.read<TextChangeCubit>().onChangePage(value);
                    onPageChange = value;
                  },
                  itemBuilder: (context, index) => pageviewSignUp[index],
                  itemCount: pageviewSignUp.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeadingTextSignup extends StatelessWidget {
  const HeadingTextSignup({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class TextFieldCustomized extends StatelessWidget {
  const TextFieldCustomized({
    Key? key,
    required this.hintText,
    this.onFieldSubmitted,
    this.node,
    this.textInputAction,
    this.value = false,
    this.onTap,
    this.controller,
    this.maxLine = 1,
    this.validator,
    this.textObstact = false,
    this.keyboardType,
    this.suffix,
  }) : super(key: key);
  final String hintText;
  final Function(String)? onFieldSubmitted;
  final FocusNode? node;
  final TextInputAction? textInputAction;
  final bool value;
  final void Function()? onTap;
  final TextEditingController? controller;
  final int maxLine;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool textObstact;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        // key: textFormKey,
        obscureText: textObstact,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        maxLines: maxLine,
        controller: controller,
        onTap: onTap,
        readOnly: value,
        textInputAction: textInputAction,
        focusNode: node,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
            suffixIcon: suffix,
            hintText: hintText,
            focusedBorder: _bordermethod(),
            border: _bordermethod(),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  OutlineInputBorder _bordermethod() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: colorPalette2));
  }
}
