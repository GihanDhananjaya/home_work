import 'package:flutter/material.dart';
import '../../../../../utils/app_colors.dart';

class BottomBarItem extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final bool isHidden;
  final String name;
  final bool isSelected;

  BottomBarItem(
      {required this.icon,
        required this.onTap,
        this.isHidden = false,
        required this.name, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 50,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Image.asset(
                icon,
                color: isSelected ? AppColors.fontColorGray:
                AppColors.fontColorWhite,
                width:25,
                height: 25,
              ),
            ),
            SizedBox(height: 5),
            Text(name,style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10,
              color: AppColors.fontColorWhite,
            ),)
          ],
        ),
      ),
    );
  }
}
