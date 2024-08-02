import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/app_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class ConfirmJobComponent extends StatefulWidget {
  final String name;
  final String title;
  final String location;
  final VoidCallback? onTap;
  final String? confirmedDate;
  final Time? time;
  final String? adminDescription;
  final String? userName;

  ConfirmJobComponent({
    required this.name,
    required this.title,
    required this.location,
    this.onTap,
    this.time,
    this.confirmedDate,
    this.adminDescription,
    this.userName
  });

  @override
  State<ConfirmJobComponent> createState() => _ConfirmJobComponentState();
}

class _ConfirmJobComponentState extends State<ConfirmJobComponent> {
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

  String formatTime(Time? time) {
    if (time == null) return 'Time not available';
    final dateTime = DateTime(0, 1, 1, time.hour, time.minute);
    return DateFormat.jm().format(dateTime); // Format to include AM/PM
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
                if (widget.onTap != null)
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
                  ),
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
                  widget.adminDescription!,
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
                          "Confirmed :",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorPrimary,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.confirmedDate ?? 'Date not available',
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
                          Icons.access_time,
                          color: AppColors.fontColorGray,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Time :",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorGray,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          formatTime(widget.time), // Use the formatTime method
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
                          "Location :",
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
                          Icons.supervisor_account_sharp,
                          color: AppColors.fontColorGray,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColorGray,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.userName!, // Use the formatTime method
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
          ],
        ),
      ),
    );
  }
}
