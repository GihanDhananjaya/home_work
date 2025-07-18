import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/views/home/widget/home_component.dart';
import 'package:home_work/views/home/widget/home_component2.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_images.dart';
import '../../utils/navigation_routes.dart';

class HomeView extends StatefulWidget {
  final User? user;


  HomeView({ this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  double _totalJobs = 0;
  double _confirmedJobs = 0;
  double _rejectedJobs = 0;

  final List<String> image =[
    AppImages.appHome5,
    AppImages.appHome6,
    AppImages.appHome7,
    AppImages.appHome8,
  ];


  Future<void> fetchJobCounts() async {
    final jobsCollection = FirebaseFirestore.instance.collection('job');
    final confirmCollection = FirebaseFirestore.instance.collection('confirm_job');
    final rejectCollection = FirebaseFirestore.instance.collection('reject_job');

    final allJobsSnapshot = await jobsCollection.get();
    final confirmJobsSnapshot = await confirmCollection.get();
    final rejectJobsSnapshot = await rejectCollection.get();

    double totalJobs = allJobsSnapshot.size.toDouble();
    double confirmedJobs = confirmJobsSnapshot.size.toDouble();
    double rejectedJobs = rejectJobsSnapshot.size.toDouble();

    print('🔥 total: $totalJobs | confirm: $confirmedJobs | reject: $rejectedJobs');

    setState(() {
      _totalJobs = totalJobs;
      _confirmedJobs = confirmedJobs;
      _rejectedJobs = rejectedJobs;
    });
  }

  double getProgress(double count) {
    if (_totalJobs == 0) return 0.0;
    double progress = count / 109;
    return progress.clamp(0.0, 1.0);
  }



  @override
  void initState() {
    fetchJobCounts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.btnGradient1.withOpacity(0.3),
      resizeToAvoidBottomInset: false,
      body: Column(
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
                      "Welcome ${widget.user?.displayName ?? 'User'},",
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration:  BoxDecoration(
                 color: AppColors.fontColorWhite
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
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
                    image: AppImages.appJob1,
                    containerBackGround:
                    AppColors.colorHover,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.allJob);
                    },
                  ),
                  const SizedBox(height: 16),
                  HomeComponent(
                    name: 'Create Job',
                    image: AppImages.appJob2,
                    containerBackGround:
                    AppColors.containerColor1,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.newJob);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: HomeComponent2(
                          name: 'Confirm Job',
                          number: getProgress(_confirmedJobs),
                          image: AppImages.appJob3,
                          containerBackGround:
                          AppColors.containerColor2,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.confirmJob);
                          },
                          presentValue: _confirmedJobs,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: HomeComponent2(
                          name: 'Rejected Job',
                          number: getProgress(_rejectedJobs),
                          image: AppImages.appJob4,
                          containerBackGround:
                          AppColors.containerColor6,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.rejectJob);
                          }, presentValue: _rejectedJobs,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 38),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: AppColors.btnGradient1),
                    width: double.infinity,
                    child: Text('Contact us to repair any home appliance in your home. ',style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white
                    ),),
                  ),

                ],
              ),
            ),
          ),
        ],
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
