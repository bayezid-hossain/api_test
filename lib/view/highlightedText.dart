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
          borderRadius: BorderRadius.circular(4.0)),

      child: new Padding(
        padding: const EdgeInsets.all(4.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(padding:EdgeInsets.all(5),child: new Text(text,style: TextStyle(fontSize: fontSize,fontWeight: fontWeight),)),

          ],
        ),
      ),
    );
  }
}
