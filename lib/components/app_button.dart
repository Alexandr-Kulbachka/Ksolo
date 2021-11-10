import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String text;
  final double textSize;
  final Color buttonColor;
  final Color textColor;
  final double height;
  final double width;
  final bool disabled;
  final void Function() onPressed;

  AppButton({
    this.margin,
    this.padding,
    this.buttonColor,
    this.textColor,
    this.text,
    this.textSize,
    this.height = 0,
    this.width = 0,
    this.disabled = false,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: width != 0 ? width : 150, minHeight: height != 0 ? height : 40),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      margin: margin ?? EdgeInsets.all(0),
      padding: padding ?? EdgeInsets.all(0),
      child: RaisedButton(
        color: buttonColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}
