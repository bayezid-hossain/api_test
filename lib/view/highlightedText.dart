import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  HighlightedText(this.text,this.color,this.fontWeight,this.fontSize);

  Widget build(BuildContext context) {
    return new Card(
      shape: new RoundedRectangleBorder(
          side: new BorderSide(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(5.0)),

      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(text,style: TextStyle(fontSize: fontSize,fontWeight: fontWeight),)),
      ),
    );
  }
}
