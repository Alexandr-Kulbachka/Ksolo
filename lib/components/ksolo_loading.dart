import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/app_color_scheme.dart';

class KsoloLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ksolo',
            style: TextStyle(
                color: AppElements.appbar.color(),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                fontFamily: 'Centaur',
                fontSize: 70),
          ),
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppElements.appbar.color()),
            ),
          )
        ],
      ),
    );
  }
}
