import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';

class MyTextFormFeild extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hitText;
  final bool? isObsecureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final double? width;
  final TextEditingController? controller;
  final Function(String?) validator;

  const MyTextFormFeild({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hitText,
    this.isObsecureText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.width,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        cursorColor: ColorsProvider.primaryBink,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 120, 167,
                      248), //! Was our primary bink but modified to diffrentiate between the error border
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorsProvider.lGray,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          fillColor: ColorsProvider.feildWhite,
          filled: true,
          hintStyle: hintStyle ?? TextStyles.font14LightGrayRegular,
          hintText: hitText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        obscureText: isObsecureText ?? false,
        style: TextStyles.font14DarkMediam,
        keyboardType: keyboardType,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
