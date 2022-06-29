import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/small_text.dart';

class ExpandedText extends StatefulWidget {
  final String text;

  const ExpandedText({Key? key,
    required this.text}) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight/7.32;

  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color: AppColors.paraColor, text: firstHalf, size: Dimensions.font16,):Column(
        children: [
          SmallText(height: 1.8, color: AppColors.paraColor, text: hiddenText?firstHalf+ "...":firstHalf+ " " +secondHalf, size: Dimensions.font16,),
          InkWell(
            onTap: (){
              setState(() {
                //sets the hidden boolean variable that controls the Show More text
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText?"Show more":"Show less", color: AppColors.mainColor, size: Dimensions.font16,),
                Icon(
                  hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,
                ),
              ],
            ),
          )
          
          
        ],
      ),
    );
  }
}
