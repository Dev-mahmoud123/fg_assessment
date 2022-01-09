import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text, fieldName;
  final double fontSize;
  final Color? color;

  const CustomText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fieldName,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$fieldName :',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        Text(
          text,
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ],
    );
  }
}
