import 'package:pcnc/util/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final Color fillColor;
  final Color hintColor;
  final int? maxLength;
  final Function onChange;

  const BuildTextField(
      {super.key,
      required this.hint,
      this.controller,
      required this.inputType,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.enabled = true,
      this.fillColor = kWhiteColor,
      this.hintColor = kGrey1,
      this.maxLength,
      required this.onChange});

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));
    return TextFormField(
      onChanged: (value) => widget.onChange(value),
      validator: (val) => val!.isEmpty ? appLocale.required : null,
      keyboardType: widget.inputType,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      maxLines: widget.inputType == TextInputType.multiline ? 3 : 1,
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        counterText: "",
        fillColor: widget.fillColor,
        filled: true,
        contentPadding:
            EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.w),
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w300,
          color: widget.hintColor,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        errorStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.error,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          borderSide: BorderSide(width: 1.w, color: kPrimaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          borderSide: BorderSide(width: 0.w, color: widget.fillColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          borderSide: BorderSide(width: 0.w, color: kGrey1),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            borderSide: BorderSide(width: 0.w, color: kGrey1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            borderSide: BorderSide(width: 1.w, color: kRed)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            borderSide: BorderSide(width: 1.w, color: kGrey1)),
        focusColor: kWhiteColor,
        hoverColor: kWhiteColor,
      ),
      cursorColor: kPrimaryColor,
      style: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        color: kBlackColor,
      ),
    );
  }
}
