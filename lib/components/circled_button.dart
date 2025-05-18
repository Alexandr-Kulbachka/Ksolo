import 'package:flutter/material.dart';

class CircledButton extends StatelessWidget {
  final double size;
  final EdgeInsets? margin;
  final IconData icon;
  final Color? buttonColor;
  final Color? iconColor;
  final void Function()? onPressed;

  const CircledButton({
    super.key,
    this.size = 10,
    this.margin,
    this.buttonColor,
    this.iconColor,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      child: RawMaterialButton(
        elevation: 0.0,
        onPressed: onPressed,
        constraints: BoxConstraints.tightFor(
          width: size,
          height: size,
        ),
        shape: const CircleBorder(),
        fillColor: buttonColor,
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.75,
        ),
      ),
    );
  }
}
