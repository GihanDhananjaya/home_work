import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/app_rectangel_shimmer.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_images.dart';
import '../sign_in/sign_in_view.dart';
import 'common/profile_component.dart';

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

  Future<void> _fetchUserData() async {
    setState(() {

    });
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Fetch additional user data from Firestore

        DocumentSnapshot userData =
        await _firestore.collection('users').doc(user.uid).get();

        setState(() {
          userName = userData['name'] ?? '';
          userEmail = userData['email'] ?? '';
          userMobileNumber = userData['phoneNumber'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _fetchUserData();
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
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 82,
                  height: 82,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: '',
                      fit: BoxFit.fill,
                      placeholder: (context, url) => AppRectangleShimmer(
                        color: AppColors.fontColorDark.withOpacity(0.8),
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: AppColors.fontColorGray.withOpacity(0.7),
                        child: Center(
                          child: Text(
                            'GD',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ProfileComponent(
              hint: 'Name',
              value: userName ?? '',
              onTap: () {},
            ),
            SizedBox(height: 10),
            ProfileComponent(
              hint: 'Email Address',
              value: userEmail ?? '',
              onTap: () {},
            ),
            SizedBox(height: 10),
            ProfileComponent(
              hint: 'Mobile Number',
              value: userMobileNumber ?? '',
              onTap: () {},
            ),
            SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.fontColorWhite,
                  borderRadius: BorderRadius.circular(6),
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
                    Expanded(
                      child: Text(
                        'Passwords',
                        style: TextStyle(
                          fontSize: AppDimensions.kFontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.fontColorGray,
                        ),
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
            SizedBox(height: 50),
            GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInView(prefs: widget.prefs)),
                  ),
                });
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.btnGradient1,
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
