import 'package:flutter/material.dart';
import 'package:meditationr_app/data_models/theme.dart';

class DecorationBackground extends StatelessWidget {
  final MeisoTheme theme;

  DecorationBackground({required this.theme});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        //foregroundにしないとデコレーションがかからない
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.black26])),
        child: Image.asset(
          theme.imagePath,
          fit: BoxFit.cover,
        ));
  }
}
