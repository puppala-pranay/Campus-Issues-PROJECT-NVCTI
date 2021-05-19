import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_NVCTI/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final bool obscureText;
  final int maxLines ;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = NowUIColors.border,
      this.controller,
      this.obscureText =false,
      this.maxLines
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: NowUIColors.muted,
        obscureText: obscureText,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        style: TextStyle(height: 1.3, fontSize: 13.0, color: NowUIColors.black),
        textAlignVertical: TextAlignVertical(y: 0.7),
        decoration: InputDecoration(
            filled: true,
            fillColor: NowUIColors.white,
            hintStyle: TextStyle(
              color: NowUIColors.time,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
