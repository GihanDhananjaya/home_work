import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:home_work/common/app_text_field.dart';
import '../../common/app_rectangel_shimmer.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import 'common/profile_component.dart';

class EditProfileDetails extends StatefulWidget {
  String userName;


  EditProfileDetails({required this.userName});

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  String? userName;
  String? userEmail;
  final nameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      nameController.text = widget.userName;
      super.initState();
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
            'Edit Profile Detals',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              AppTextField(hint: 'Name',controller: nameController,),
              const SizedBox(height: 10),
              ProfileComponent(
                hint: 'Email Address',
                value: userEmail ?? '',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
