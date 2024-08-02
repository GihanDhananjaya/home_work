import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/utils/app_colors.dart';

class DateAndTimeComponent extends StatelessWidget {
  IconData icon;
  String name;


  DateAndTimeComponent({required this.icon,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.fontColorGray,spreadRadius: 0,blurRadius: 2)],
        color: AppColors.fontColorWhite,
      ),
      child: Row(
        children: [
          Icon(icon,size: 20,),
          SizedBox(width: 20,),
          Text(name,style: TextStyle(
              color: AppColors.fontColorDark,
              fontSize: 12,
              fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}
