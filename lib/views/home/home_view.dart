import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/views/home/widget/chart_component.dart';
import 'package:home_work/views/home/widget/home_component.dart';
import 'package:home_work/views/home/widget/home_component2.dart';
import 'package:home_work/views/home/widget/service_component.dart';
import 'package:intl/intl.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_images.dart';
import '../new_job/new_job_view.dart';

class HomeView extends StatefulWidget {
  final User? user;


  HomeView({ this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final List<String> image =[
    AppImages.appHome5,
    AppImages.appHome6,
    AppImages.appHome7,
    AppImages.appHome8,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.btnGradient1.withOpacity(0.3),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.btnGradient1,
                  AppColors.fontColorDark
                ])
              ),
        
              child: Row(
                children: [
                  Image.asset(AppImages.appHome2Img),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Gihan,",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: AppDimensions.kFontSize14,
                          color: AppColors.fontColorWhite,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        getTimeOfDayGreeting(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppDimensions.kFontSize18,
                          color: AppColors.fontColorWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ChartComponent(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration:  BoxDecoration(
                //color: AppColors.colorBackground,
                  gradient: LinearGradient(colors: [
                    AppColors.btnGradient1.withOpacity(0.3),
                    AppColors.fontColorDark.withOpacity(0.3)
                  ])
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      getFormattedDate(),
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
                        color: AppColors.fontColorSuccess,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    HomeComponent(
                      name: 'All Job',
                      number: 5,
                      image: AppImages.appJob1,
                      containerBackGround:
                      AppColors.colorHover,
                      onTap: () {
                        Navigator.pushNamed(context, '/all_job_view');
                      },
                    ),
                    SizedBox(height: 8),
                    HomeComponent(
                      name: 'Create Job',
                      number: 5,
                      image: AppImages.appJob2,
                      containerBackGround:
                      AppColors.containerColor1,
                      onTap: () {
                        Navigator.pushNamed(context, '/new_job');
                      },
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: HomeComponent2(
                            name: 'Confirm Job',
                            number: 5,
                            image: AppImages.appJob3,
                            containerBackGround:
                            AppColors.containerColor2,
                            onTap: () {
                              Navigator.pushNamed(context, '/confirm_job_view');
                            },
                          ),
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: HomeComponent2(
                            name: 'Rejected DEFs',
                            number: 5,
                            image: AppImages.appJob4,
                            containerBackGround:
                            AppColors.containerColor6,
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, Routes.kDefListView,
                              //     arguments: 4);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 38),
                    // Container(
                    //   height: 200,
                    //   width: double.infinity,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.only(left: 0,top: 8),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: image.length,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       return ServiceComponent(image: image[index],);
                    //     },
                    //   ),
                    // ),
        
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    int day = now.day;
    String suffix = day.toString().endsWith('1')
        ? 'st'
        : day.toString().endsWith('2')
        ? 'nd'
        : day.toString().endsWith('3')
        ? 'rd'
        : 'th';

    String formattedDate =
        'Today $day$suffix ${DateFormat('MMM yyyy').format(now)}';

    return formattedDate;
  }

  String getTimeOfDayGreeting() {
    int hour;
    DateTime now = DateTime.now();
    hour = now.hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

}
