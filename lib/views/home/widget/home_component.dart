
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


import '../../../../../utils/app_dimensions.dart';
import '../../../utils/app_colors.dart';

class HomeComponent extends StatelessWidget {
  String name;
  int number;
  String image;
  Color containerBackGround;
  VoidCallback onTap;

  HomeComponent(
      {required this.name,
      required this.number,
      required this.image,
      required this.containerBackGround,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: 18,
          right: 25,
        ),
        height: 77,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: AppColors.fontColorGray,
            spreadRadius: 0.1,
            blurRadius: 4
          )],
          color: containerBackGround,

          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 50,height: 50,
              decoration: BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ), child: Image.asset(
                image,
                height: 87,
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: AppDimensions.kFontSize14,
                  color: AppColors.fontColorWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 10),
            CircularPercentIndicator(
              backgroundColor: AppColors.colorDisableWidgetWeb,
              linearGradient: LinearGradient(colors: [
                AppColors.containerColor10,
                AppColors.containerColor12
              ]),
              radius: 25.0,
              lineWidth: 6.16,
              animation: true,
              percent: 0.7,
              circularStrokeCap: CircularStrokeCap.round,
              center: new Text("100%",style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.fontColorWhite,fontSize: AppDimensions.kFontSize10),),
            ),
          ],
        ),
      ),
    );
  }
}
