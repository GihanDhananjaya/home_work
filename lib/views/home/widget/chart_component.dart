import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_dimensions.dart';

class ChartComponent extends StatefulWidget {
  const ChartComponent({super.key});

  @override
  State<ChartComponent> createState() => _ChartComponentState();
}

class _ChartComponentState extends State<ChartComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.0,left: 12,bottom: 12,top: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9,vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            width: 1,
            color: AppColors.fontColorSuccess
          )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leads',
                  style: TextStyle(
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.fontColorSuccess,
                  ),
                ),
                Text(
                  '2024 August',
                  style: TextStyle(
                    fontSize: AppDimensions.kFontSize10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.fontColorSuccess,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedRadialGauge(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  radius: 59,
                  axis: GaugeAxis(
                    min: 0,
                    max: 100,
                    degrees: 360,
                    style: GaugeAxisStyle(
                      thickness: 9,
                      background: AppColors.fontColorSuccess,
                      cornerRadius: Radius.circular(0),
                    ),
                    segments: [
                      GaugeSegment(
                        from: 0,
                        to: 30, // Changed (27 - 8) to 19 for example
                        color: AppColors.fontColorHover,
                        cornerRadius: Radius.circular(0),
                      ),
                      GaugeSegment(
                        from: 30, // Changed (12 - 6) to 6 for example
                        to: 50,
                        color: AppColors.btnGradient1,
                        cornerRadius: Radius.circular(0),
                      ),
                      GaugeSegment(
                        from: 50, // Changed (12 - 6) to 6 for example
                        to: 70,
                        color: AppColors.btnGradient1,
                        cornerRadius: Radius.circular(0),
                      ),
                    ],
                    pointer: null,
                  ),
                  builder: (context, child, value) => Center(
                    child: Transform.rotate(
                      angle: 360 * (3.141592653589793 / 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'All Leads',
                            style: TextStyle(
                              fontSize: AppDimensions.kFontSize10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.btnGradient1,
                            ),
                          ),
                          Text(
                            '94.2K',
                            style: TextStyle(
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.btnGradient1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  value: 0, // Ensure this is the intended initial value
                ),
                SizedBox(width: 16,),
                Container(height: 91, width: 1,
                    color: AppColors.btnGradient1),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.fontColorSuccess,
                              shape: BoxShape.rectangle
                          ),
                          width: 9,height: 9,
                        ),
                        SizedBox(width: 4,),
                        Text('All Job  :',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize10),),
                        SizedBox(width: 10,),

                        Text('12345',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize12),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.colorPrimary,
                              shape: BoxShape.rectangle
                          ),
                          width: 9,height: 9,
                        ),
                        SizedBox(width: 4,),
                        Text('Create Job  :',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize10),),
                        SizedBox(width: 10,),
                        Text('12345',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize12),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.fontColorHover,
                              shape: BoxShape.rectangle
                          ),
                          width: 9,height: 9,
                        ),
                        SizedBox(width: 4,),
                        Text('Confirm Job :',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize10),),
                        SizedBox(width: 10,),
                        Text('12345',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize12),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.btnGradient1,
                              shape: BoxShape.rectangle
                          ),
                          width: 9,height: 9,
                        ),
                        SizedBox(width: 4,),
                        Text('Reject  :',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize10),),
                        SizedBox(width: 10,),
                        Text('12345',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.btnGradient1,
                            fontSize: AppDimensions.kFontSize12),),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
