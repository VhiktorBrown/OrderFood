import 'package:flutter/cupertino.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({Key? key, this.color = const Color(0XFF332d2b),
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size == 0?Dimensions.font20:size,
      ),
    );
  }
}
