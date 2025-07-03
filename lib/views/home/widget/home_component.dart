
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


import '../../../../../utils/app_dimensions.dart';
import '../../../utils/app_colors.dart';

class HomeComponent extends StatelessWidget {
  String name;
  String image;
  Color containerBackGround;
  VoidCallback onTap;

  HomeComponent(
      {required this.name,
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
          ],
        ),
      ),
    );
  }
}
