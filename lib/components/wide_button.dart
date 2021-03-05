import 'package:flutter/material.dart';
import 'package:pokemons/theme.dart';

class WideButton extends StatelessWidget {

  final Color color;
  final String text;
  final void Function() onPressed;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;
  final TextStyle textStyle;
  final double borderRadius;

  WideButton(
    {
      this.color = Colors.red,
      @required
      this.text,
      this.onPressed,
      this.textColor = Colors.white,
      this.padding = const EdgeInsets.all(0),
      this.height = 56,
      this.width,
      this.textStyle,
      this.borderRadius = 5
    }
  );

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      color: color,
      padding: padding,
      height: height,
      minWidth: width,
      onPressed: onPressed, 
      child: Text(
        text,
        style: textStyle ?? TextStyle(
          fontSize: 16,
          color: textColor,
          letterSpacing: 0.16,
          fontFamily: font,
          fontWeight: FontWeight.w700,
        ),
      )
    );
  }
}