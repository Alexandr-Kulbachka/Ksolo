import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double size;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String text;
  final double textSize;
  final Color buttonColor;
  final Color textColor;
  final double maxHeight;
  final double maxWidth;
  final void Function() onPressed;

  AppButton({
    this.size = 10,
    this.margin,
    this.padding,
    this.buttonColor,
    this.textColor,
    this.text,
    this.textSize,
    this.maxHeight = 0,
    this.maxWidth = 0,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      child: FlatButton(
        color: buttonColor,
        child: Container(
          padding: padding ?? EdgeInsets.all(0),
          constraints: BoxConstraints(
              maxHeight: maxHeight != 0 ? maxHeight : 50,
              maxWidth: maxWidth != 0 ? maxWidth : 100),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
