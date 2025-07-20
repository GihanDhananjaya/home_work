import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_rectangel_shimmer.dart';
import '../../common/show_dialog.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_images.dart';
import '../../utils/navigation_routes.dart';
import '../sign_in/sign_in_view.dart';
import 'common/profile_component.dart';

class UserData{
  final String userName;
  final String email;
  final String mobileNumber;
  final int userId;

  UserData({required this.userName, required this.email,required this.mobileNumber,required this.userId});
}


class UserProfile extends StatefulWidget {
  get prefs => null;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? userName;
  String? userEmail;
  String? userMobileNumber;
  int? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }



  Future<void> _fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Check if data already exists in SharedPreferences
      if (prefs.containsKey('userName') &&
          prefs.containsKey('userEmail') &&
          prefs.containsKey('mobile') &&
          prefs.containsKey('user_id')) {
        // Load from SharedPreferences
        setState(() {
          userName = prefs.getString('userName');
          userEmail = prefs.getString('userEmail');
          userMobileNumber = prefs.getString('mobile');
          userId = prefs.getInt('user_id');
        });
        return; // Stop here (don’t fetch from Firestore)
      }

      // First-time fetch from Firestore
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData =
        await _firestore.collection('users').doc(user.uid).get();

        userName = userData['name'] ?? '';
        userEmail = userData['email'] ?? '';
        userMobileNumber = userData['mobile'] ?? '';
        userId = userData['user_id'] is int
            ? userData['user_id']
            : int.tryParse(userData['user_id'].toString()) ?? 0;

        setState(() {});

        // Save to SharedPreferences
        await prefs.setString('userName', userName!);
        await prefs.setString('userEmail', userEmail!);
        await prefs.setString('mobile', userMobileNumber!);
        await prefs.setInt('user_id', userId!);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
      userMobileNumber = prefs.getString('mobile');
      userId = prefs.getInt('user_id');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.btnGradient1, AppColors.fontColorDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Center(
          child: Text(
            'User Profile',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       width: 82,
              //       height: 82,
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(100),
              //         child: CachedNetworkImage(
              //           imageUrl: '',
              //           fit: BoxFit.fill,
              //           placeholder: (context, url) => AppRectangleShimmer(
              //             color: AppColors.fontColorDark.withOpacity(0.8),
              //             height: double.infinity,
              //             width: double.infinity,
              //           ),
              //           errorWidget: (context, url, error) => CircleAvatar(
              //             backgroundColor: AppColors.fontColorGray.withOpacity(0.7),
              //             child: Center(
              //               child: Text(
              //                 userName!?? "User Name",
              //                 style: TextStyle(
              //                   color: AppColors.fontColorWhite,
              //                   fontSize: AppDimensions.kFontSize28,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.btnGradient1,
                      AppColors.containerColor4,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        InkResponse(
                          onTap: (){
                            Navigator.pushNamed(context, AppRoutes.editProfile,arguments: UserData(userName: userName!,
                                email: userEmail!, mobileNumber: userMobileNumber!, userId: userId!));
                          },
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: AppColors.fontColorWhite,
                          ),
                        ),
                      ],
                    ),
                    ProfileComponent(
                      hint: 'Name',
                      value: userName ?? '',
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    ProfileComponent(
                      hint: 'Email Address',
                      value: userEmail ?? '',
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    ProfileComponent(
                      hint: 'Mobile Number',
                      value: "+94 ${userMobileNumber}" ?? '',
                      onTap: () {},
                    ),
                    const SizedBox(height: 22),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.fontColorWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.fontColorGray,
                            width: 0.75,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.icLock,
                              height: 20,
                              color: AppColors.containerColor6,
                            ),
                            SizedBox(width: 32),
                            Text(
                              'Passwords',
                              style: TextStyle(
                                fontSize: AppDimensions.kFontSize14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontColorGray,
                              ),
                            ),
                            Image.asset(
                              AppImages.appArrowLeft,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              GestureDetector(
                onTap: () {
                  CommonDialogUtil.showAppDialog(
                    context: context,
                    title: 'Logout',
                    description: 'Are you sure you want to log out?',
                    onPositiveCallback: () async {

                      await FirebaseAuth.instance.signOut();

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInView(prefs: prefs),
                        ),
                      );
                    },
                    positiveButtonText: "Yes",
                    negativeButtonText: "No",
                    onNegativeCallback: (){}
                  );
                },
                child: Container(
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.containerColor13,
                        AppColors.containerColor4,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.appLogout,
                        height: 20,
                        color: AppColors.fontColorWhite,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: AppDimensions.kFontSize14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
