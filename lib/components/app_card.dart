import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/app_color_scheme.dart';

class AppCard extends StatelessWidget {
  final Widget content;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;

  const AppCard(this.content, {super.key, this.margin, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(15),
      padding: padding ?? const EdgeInsets.all(0),
      decoration:
          BoxDecoration(color: color ?? AppElements.simpleCard.color(), borderRadius: BorderRadius.circular(15)),
      child: content,
    );
  }
}
