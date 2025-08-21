import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:home_work/common/app_button.dart';
import 'package:home_work/utils/app_colors.dart';
import 'package:home_work/views/new_job/widget/date_component.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/app_dropdown_field.dart';
import '../../common/app_mobile_number_field.dart';
import '../../common/app_text_field.dart';
import '../../common/show_dialog.dart';

class NewJobView extends StatefulWidget {
  @override
  State<NewJobView> createState() => _NewJobViewState();
}

class _NewJobViewState extends State<NewJobView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final deviceTypeController = TextEditingController();
  final mobileNumberController = TextEditingController();
  AppDropdownData? _brandType;
  AppDropdownData? _deviceType;
  DateTime selectedOpaimentDate = DateTime.now();
  String? selectedFormatDate;
  PhoneNumber? phoneNumber;
  final focusNode = FocusNode();

  List<AppDropdownData> brand = [
    AppDropdownData(id: 1, data: 'Singer'),
    AppDropdownData(id: 2, data: 'LG'),
    AppDropdownData(id: 3, data: 'Damro'),
    AppDropdownData(id: 4, data: 'Hairer'),
    AppDropdownData(id: 5, data: 'KDK'),
    AppDropdownData(id: 6, data: 'Usha'),
    AppDropdownData(id: 7, data: 'Samsung'),
    AppDropdownData(id: 8, data: 'Toshiba'),
    AppDropdownData(id: 9, data: 'Philips'),
    AppDropdownData(id: 10, data: 'Panasonic'),
  ];

  List<AppDropdownData> device = [
    AppDropdownData(id: 1, data: 'Washing machine'),
    AppDropdownData(id: 2, data: 'Gas Cooker'),
    AppDropdownData(id: 3, data: 'Rice Cooker'),
    AppDropdownData(id: 4, data: 'Blender'),
    AppDropdownData(id: 5, data: 'Hot Water Shower'),
    AppDropdownData(id: 6, data: 'Fan'),
    AppDropdownData(id: 7, data: 'Oven'),
    AppDropdownData(id: 8, data: 'Toaster'),
    AppDropdownData(id: 9, data: 'Speaker'),
    AppDropdownData(id: 10, data: 'other'),
  ];

  @override
  void initState() {
    selectedFormatDate = DateFormat('MMM d, yyyy').format(selectedOpaimentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.btnGradient1,
                AppColors.fontColorDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Create Job',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Your Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.fontColorGray),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                          color: AppColors.fontLabelGray,
                          height: 2,
                        ))
                      ],
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      inputType: TextInputType.name,
                      controller: nameController,
                      hint: 'User Name',
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 20),
                    // AppMobileNumberField(
                    //   appMobileNumberController: AppMobileNumberController(),
                    //   focusNode: focusNode,
                    //   initialCountryCode: phoneNumber != null
                    //       ? phoneNumber!.countryCode.replaceAll('+', '')
                    //       : null,
                    //   onChange: (phone) {
                    //     setState(() {
                    //       if (phone.number.isNotEmpty) {
                    //         phoneNumber = phone;
                    //       } else {
                    //         if (phoneNumber != null) {
                    //           phoneNumber!.number = '';
                    //         }
                    //       }
                    //     });
                    //   },
                    //   controller: mobileNumberController,
                    //   onCountryChange: (country) {
                    //     focusNode.requestFocus();
                    //   },
                    // ),
                    SizedBox(height: 20),
                    AppTextField(
                      inputType: TextInputType.name,
                      controller: locationController,
                      hint: 'Your Location',
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your Device Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppColors.fontColorGray)),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                          color: AppColors.fontLabelGray,
                          height: 2,
                        ))
                      ],
                    ),
                    SizedBox(height: 20),
                    AppDropDownField(
                      guideTitle: "Select Brand",
                      width: 150,
                      dropDownHint: 'Select Brand',
                      dataSet: brand,
                      selectedValue: _brandType?.id,
                      // Use null-aware operator
                      onSelect: (value) {
                        setState(() {
                          _brandType = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    AppDropDownField(
                      guideTitle: "Select Device",
                      width: 150,
                      dropDownHint: 'Select Device',
                      dataSet: device,
                      selectedValue: _deviceType?.id,
                      // Use null-aware operator
                      onSelect: (value) {
                        setState(() {
                          _deviceType = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      inputType: TextInputType.name,
                      controller: deviceTypeController,
                      hint: 'Device Type',
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      inputType: TextInputType.name,
                      controller: descriptionController,
                      hint: 'Please Explain your device problem',
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Please Select Your Available Day',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppColors.fontColorGray)),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                          color: AppColors.fontLabelGray,
                          height: 2,
                        ))
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: DateComponent(
                        icon: Icons.date_range,
                        name: selectedFormatDate!,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: AppButton(
              buttonColor: AppColors.containerColor1,
              buttonText: 'Submit',
              onTapButton: () async {
                _validate();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedOpaimentDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedOpaimentDate) {
      setState(() {
        selectedOpaimentDate = picked;
        selectedFormatDate =
            DateFormat('MMM d, yyyy').format(selectedOpaimentDate);
      });
    }
  }

  _validate() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not logged in'),
        ),
      );
      return;
    }

    // Fetch the user's role from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    String userRole = userDoc['user_role'] ?? '';

    if(nameController.text.isEmpty){
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Error',
        description: 'Please enter your name',
      );
    }
    // else if (mobileNumberController.text.isEmpty) {
    //   CommonDialogUtil.showAppDialog(
    //     context: context,
    //     title: 'Error',
    //     description: 'Please enter your mobileNumber',
    //   );
    // }
    else if (locationController.text.isEmpty) {
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Error',
        description: 'Please enter your location',
      );
    }else if (_brandType == null) {
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Error',
        description: 'Please select your brand',
      );
    } else if (_deviceType == null) {
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Error',
        description: 'Please select your device',
      );
    } else if (deviceTypeController.text.isEmpty) {
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Error',
        description: 'Please enter your device number',
      );
    }else if (descriptionController.text.isEmpty) {
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Error',
        description: 'Please enter your description',
      );
    }
    else {
      Map<String, dynamic> jobData = {
        'user_id': currentUser.uid, // Add user ID to the job data
        'name': nameController.text,
        'location': locationController.text,
        'description': descriptionController.text,
        'device_type': deviceTypeController.text,
        'category': _brandType!.data,
        'device': _deviceType!.data,
        'date': selectedFormatDate!,
        'mobile_number': mobileNumberController.text,
        'user_role': userRole
      };

      // Add the data to Firestore
      await FirebaseFirestore.instance
          .collection('job')
          .add(jobData);

      // Clear the fields after submission
      nameController.clear();
      descriptionController.clear();
      locationController.clear();
      deviceTypeController.clear();
      mobileNumberController.clear();
      setState(() {
        _brandType = null;
        _deviceType = null;
        phoneNumber = null;
        selectedOpaimentDate = DateTime.now();
        selectedFormatDate =
            DateFormat('MMM d, yyyy').format(selectedOpaimentDate);
      });
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Success',
        description: 'Job created successfully!',
        positiveButtonText: 'OK',
      );
    }
  }
}
