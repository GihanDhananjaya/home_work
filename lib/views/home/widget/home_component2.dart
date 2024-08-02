import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimensions.dart';

class HomeComponent2 extends StatelessWidget {
  String name;
  int number;
  String image;
  Color containerBackGround;
  VoidCallback onTap;

  HomeComponent2(
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
          left: 14,
          right: 9,
          top: 19,
          bottom: 19
        ),

        decoration: BoxDecoration(
          color: containerBackGround,
          border: Border.all(
            color: AppColors.fontColorDark,
            width: 0.5,
          ),
          boxShadow: [BoxShadow(
              spreadRadius: 1,
              blurRadius: 0.5,
              color: AppColors.fontColorGray.withOpacity(0.5))],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
            image,
            height: 77,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDimensions.kFontSize13,
                      color: AppColors.fontColorWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20,),
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
          ],
        ),
      ),
    );
  }
}
