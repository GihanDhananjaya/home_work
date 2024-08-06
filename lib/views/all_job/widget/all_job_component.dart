import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/common/app_text_field.dart';
import 'package:intl/intl.dart';

import '../../../common/app_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';
import 'date_and_time_component.dart';

class AllJobComponent extends StatefulWidget {
  final String name;
  final String? title;
  final String location;
  final String? description;
  final String? mobileNumber;
  final String? userName;
  final VoidCallback? onTap;
  final VoidCallback? setTime;
  final String? addedDate;
  Time? showTime;
  String? showDate;
  final VoidCallback? setDate;
  final TextEditingController? adminDescriptionController;
  final String? isAdmin;

  AllJobComponent({required this.name,
    this.title,
    required this.location,
    this.description,
    this.onTap,this.setTime,
    this.setDate,
    this.addedDate,
    this.mobileNumber,
    this.showDate,
    this.userName,
    this.showTime,this.adminDescriptionController,
    this.isAdmin
  });

  @override
  State<AllJobComponent> createState() => _AllJobComponentState();
}

class _AllJobComponentState extends State<AllJobComponent> {
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
  String? selectedFormatDate;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedFormatDate = DateFormat('MMM d, yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.fontColorWhite,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: AppColors.fontColorDark.withOpacity(0.25),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.name}  - ${widget.title}',
                  style: TextStyle(
                    color: AppColors.fontColorDark,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.kFontSize14,
                  ),
                ),
                widget.isAdmin! == 'admin' ?
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    width: 65,
                    height: 21,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.fontColorSuccess,
                    ),
                    child: Center(
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(
                          fontSize: AppDimensions.kFontSize8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorReviewing,
                        ),
                      ),
                    ),
                  ),
                ):SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.fontColorDark,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  widget.description!,
                  style: TextStyle(
                    fontSize: AppDimensions.kFontSize10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appColorAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.fontColorSuccess,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Job Added :",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorPrimary,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.addedDate!,
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.fontColorDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.fontColorGray,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Location:",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorGray,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.location,
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.fontColorDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.perm_identity,
                          color: AppColors.fontColorGray,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "User_Name :",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorGray,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.userName!,
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.fontColorDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: AppColors.fontColorGray,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Mobile_Number :",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorGray,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.mobileNumber!,
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.fontColorDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 58),
                Container(
                  height: 50.0,
                  width: 1.0,
                  color: AppColors.fontColorGray,
                ),
                SizedBox(width: 35),
                Column(
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.containerColor13,
                      ),
                    ),
                    Text(
                      formattedDate,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.containerColor13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            ///Admin Part

            widget.isAdmin! == 'admin' ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                        onTap: widget.setTime,
                        child: DateAndTimeComponent(icon: Icons.timelapse, name: 'Set  Time',)),
                    SizedBox(height: 10,),
                    Text("${widget.showTime!}")
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: widget.setDate,
                        child: DateAndTimeComponent(icon: Icons.date_range, name: 'Set  Date',)),
                    SizedBox(height: 10,),
                    Text(
                      widget.showDate != null
                          ? widget.showDate!
                          : 'No date selected',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ):SizedBox.shrink(),
            widget.isAdmin! == 'admin'?
            SizedBox(height: 20):SizedBox.shrink(),
            widget.isAdmin! == 'admin'?
            AppTextField(hint: 'Admin Description',controller: widget.adminDescriptionController,):SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
