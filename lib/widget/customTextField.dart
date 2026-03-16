import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool? filled;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    this.readOnly,
    this.textInputAction,
    this.onChanged,
    this.onTap,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontFamily : 'WorkSans',
        fontSize: 15.sp
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled ?? true,
        fillColor: fillColor ?? whiteColor,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.8.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20.sp),
          borderSide: BorderSide(
            color: borderColor ?? greyBorderColor,
            width: borderWidth ?? 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20.sp),
          borderSide: BorderSide(
            color: borderColor ?? greyBorderColor,
            width: borderWidth ?? 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20.sp),
          borderSide: BorderSide(
            color: borderColor ?? greyBorderColor,
            width: borderWidth ?? 1.5,
          ),
        ),
      ),
    );
  }
}

