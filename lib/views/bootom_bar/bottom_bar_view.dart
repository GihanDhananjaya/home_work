import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/views/bootom_bar/widget/bottom_bar_item_component.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../home/home_view.dart';
import '../user_profile/user_profile_view.dart';

class BottomBarView extends StatefulWidget {
  final User? user;


  BottomBarView({ this.user});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int _selectedPage = 0;
  bool _isAdmin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Fetch the user role from Firestore when the BottomBarView is created
    fetchUserRole();
  }

  // void fetchUserRole() async {
  //   try {
  //     DocumentSnapshot userDoc =
  //     await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //
  //     if (userDoc.exists) {
  //       String userRole = userDoc['userRole'] ?? 'User';
  //       setState(() {
  //         _isAdmin = (userRole == 'Admin');
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching user role: $e');
  //   }
  // }

  void fetchUserRole() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        final DocumentSnapshot userData = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userData.exists) {
          String userRole = userData['userRole'] ?? 'User';
          setState(() {
            _isAdmin = (userRole == 'Admin');
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColors.btnGradient1,
            AppColors.fontColorDark,
          ],begin: Alignment.topLeft,
            end: Alignment.bottomRight,)
        ),
        child: BottomAppBar(
          height: 67,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(top: 5),
          color: AppColors.btnGradient1.withOpacity(0.3),
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomBarItem(
                name: 'HOME',
                icon: AppImages.appHome1,
                onTap: () {
                  if (_selectedPage != 0) {
                    setState(() {
                      _selectedPage = 0;
                    });
                  }
                }, isSelected: _selectedPage == 0,
              ),
              BottomBarItem(
                name: 'Community',
                icon: AppImages.appAssigner,
                onTap: () {
                  if (_selectedPage != 1) {
                    setState(() {
                      _selectedPage = 1;
                    });
                  }
                }, isSelected: _selectedPage == 1,
              ),
              if (_isAdmin)
                Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkResponse(
                  onTap: (){
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AddBookView()),
                    // );
                  },
                  child: Container(
                    child: Icon(Icons.add,
                        color: AppColors.fontColorWhite),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),color: AppColors.fontColorGray,

                    ),
                  ),
                ),
              ),
              BottomBarItem(
                name: 'Notification',
                icon: AppImages.appNotification,
                onTap: () {
                  if (_selectedPage != 2) {
                    setState(() {
                      _selectedPage = 2;
                    });
                  }
                }, isSelected: _selectedPage == 2,
              ),
              BottomBarItem(
                name: 'Profile',
                icon: AppImages.icUser,
                onTap: () {
                  if (_selectedPage != 3) {
                    setState(() {
                      _selectedPage = 3;
                    });
                  }
                },
                isSelected:  _selectedPage == 3,
              ),
              // BottomBarItem(
              //   icon: AppImages.icHomeAction,
              //   onTap: () {
              //     if (AppConstants.IS_PAYMENT_DONE) {
              //       Navigator.pushNamed(context, Routes.kPackageDetailUI);
              //     } else {
              //       Navigator.pushNamed(context, Routes.kOnlinePaymentView);
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //
      //     backgroundColor: AppColors.colorPrimary,
      //     onPressed: () {
      //
      //     },
      //     child:  Icon(Icons.add),
      // ),
    );
  }


  _getBody() {
    switch (_selectedPage) {
      case 0:
        return HomeView();
      case 1:
        return HomeView();
      case 2:
        return HomeView();
      default:
        return UserProfile();
    }
  }
}


