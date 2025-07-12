import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/utils/app_colors.dart';

class DateComponent extends StatelessWidget {
  IconData icon;
  String name;


  DateComponent({required this.icon,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorDisableWidget),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.fieldBackgroundColor,
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
