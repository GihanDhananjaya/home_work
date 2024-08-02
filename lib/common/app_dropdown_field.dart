import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class AppDropdownData {
  final int id;
  final String data;

  AppDropdownData({required this.id, required this.data});
}

class AppDropDownField extends StatelessWidget {
  final String? dropDownHint;
  final String? guideTitle;
  final bool? isMandetory;
  final double? width;
  final List<AppDropdownData> dataSet;
  final int? selectedValue;
  final Function(AppDropdownData) onSelect;
  final Color? guidLineColor;

  AppDropDownField({
    required this.dataSet,
    this.selectedValue,
    this.dropDownHint,
    this.width,
    this.guideTitle,
    this.isMandetory = false,
    required this.onSelect,
    this.guidLineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only( left: 5,
            bottom: 6,),
          child: Text(
            guideTitle ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppDimensions.kFontSize16,
              color: AppColors.fontColorDark,
            ),
          ),
        ),
        SizedBox(height: 5),
        DropdownButtonFormField2<int>(
          hint: Text(
            dropDownHint ?? 'Select item',
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: AppColors.appColorAccent,
              fontSize: AppDimensions.kFontSize14,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: dataSet
              .map((item) => DropdownMenuItem<int>(
            value: item.id,
            child: Container(
              width: width ?? 85,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                item.data,
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.appColorAccent,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ))
              .toList(),
          value: selectedValue,
          alignment: Alignment.centerLeft,
          onChanged: (value) {
            AppDropdownData? data;
            for (var element in dataSet) {
              if (element.id == value) {
                data = element;
                break;
              }
            }
            onSelect(data!);
          },
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.fontColorWhite,
          ),
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
            fontSize: AppDimensions.kFontSize14,
            color: AppColors.appColorAccent,
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.fontLabelGray,width: 1.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.fontLabelGray,width: 1.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              errorStyle: TextStyle(
                color: AppColors.colorFailed,
                fontSize: AppDimensions.kFontSize12,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.only(bottom: 24, right: 16),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.fontLabelGray,width: 1.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              filled: true,
              fillColor: AppColors.fieldBackgroundColor),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.fontColorDark,
          ),
        ),
      ],
    );
  }
}
