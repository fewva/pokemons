import 'package:flutter/material.dart';
import 'package:pokemons/theme.dart';

class DecoratedCharacteristic extends StatelessWidget {

  final String name;
  final String info;
  final bool italics;
  

  const DecoratedCharacteristic({
    @required this.name,
    @required this.info,
    this.italics = false,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: name + ': ',
        style: TextStyle(
          color: Colors.black38,
          fontFamily: font,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          height: 1.5
        ),
        children: [
          TextSpan(
            text: info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.black,
              fontStyle: italics
                ? FontStyle.italic
                : FontStyle.normal
            )
          )
        ]
      ),
    );
  }
}