import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final EdgeInsets padding;
  final int maxLines;
  final Color cursorColor;
  final String labelText;
  final double labelSize;
  final Color labelColor;
  final String errorText;
  final double cursorWidth;
  final double borderRadius;
  final double borderWidth;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final TextEditingController fieldController;
  final FocusNode fieldFocusNode;
  final void Function(String text) onChanged;
  final void Function() onTap;

  const AppTextField({
    Key key,
    this.padding,
    this.maxLines = 1,
    this.cursorColor,
    this.labelText,
    this.cursorWidth = 2.0,
    this.fieldController,
    this.fieldFocusNode,
    this.labelSize = 22,
    this.labelColor,
    this.borderRadius = 5.0,
    this.borderWidth = 2.0,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.errorText,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.all(0),
        child: TextField(
          controller: fieldController ?? TextEditingController(),
          focusNode: fieldFocusNode ?? FocusNode(),
          maxLines: maxLines,
          cursorColor: cursorColor,
          cursorWidth: cursorWidth,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: labelSize,
              color: labelColor,
            ),
            errorText: errorText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: borderWidth,
                color: disabledBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: borderWidth,
                color: enabledBorderColor,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onChanged: onChanged,
          onTap: onTap,
        ));
  }
}
