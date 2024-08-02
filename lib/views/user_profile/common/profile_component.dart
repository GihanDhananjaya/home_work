import 'package:flutter/material.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimensions.dart';

class ProfileComponent extends StatefulWidget {
  final String hint;
  final String value;
  final VoidCallback onTap;

  const ProfileComponent({
    super.key,
    required this.hint,
    required this.value,
    required this.onTap,
  });

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  //double borderRadius = 40;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 5,
            bottom: 6,
          ),
          child: Text(
            widget.hint,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppDimensions.kFontSize14,
              color: AppColors.fontColorDark,
            ),
          ),
        ),
        InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.fontLabelGray,width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: AppColors.fieldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Text(
                    widget.value,
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.kFontSize14,
                      color: AppColors.fontColorGray,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.edit,
                  size: 18,
                  color: AppColors.fontColorDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
