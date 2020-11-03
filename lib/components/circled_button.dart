import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircledButton extends StatelessWidget {
  final double size;
  final EdgeInsets margin;
  final IconData icon;
  final Color buttonColor;
  final Color iconColor;
  final void Function() onPressed;

  CircledButton({
    this.size = 10,
    this.margin,
    this.buttonColor,
    this.iconColor,
    @required this.icon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      child: RawMaterialButton(
        elevation: 0.0,
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.75,
        ),
        onPressed: onPressed,
        constraints: BoxConstraints.tightFor(
          width: size,
          height: size,
        ),
        shape: CircleBorder(),
        fillColor: buttonColor,
      ),
    );
  }
}
