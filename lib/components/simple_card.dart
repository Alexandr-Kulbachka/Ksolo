import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_manager/enums/app_elements.dart';
import 'package:list_manager/style/app_color_scheme.dart';

class SimpleCard extends StatelessWidget {
  Widget content;
  EdgeInsets margin;
  EdgeInsets padding;
  Color color;

  SimpleCard(this.content, {this.margin, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(15),
      padding: padding ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: color ?? AppElements.simpleCard.color(),
          borderRadius: BorderRadius.circular(15)),
      child: content,
    );
  }
}
