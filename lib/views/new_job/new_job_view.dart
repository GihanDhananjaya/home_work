import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_work/common/app_button.dart';
import 'package:home_work/utils/app_colors.dart';
import 'package:home_work/views/new_job/widget/date_component.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/app_dropdown_field.dart';
import '../../common/app_mobile_number_field.dart';
import '../../common/app_text_field.dart';

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
  AppDropdownData? _categoryType;
  AppDropdownData? _deviceType;
  DateTime selectedOpaimentDate = DateTime.now();
  String? selectedFormatDate;
  PhoneNumber? phoneNumber;
  final focusNode = FocusNode();

  @override
  void initState() {
    _categoryType = AppDropdownData(id: 1, data: 'Singer'); // Initialize _genderType properly
    _deviceType = AppDropdownData(id: 1, data: 'TV');
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
                  AppColors.fontColorDark
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            'Create Job',
            style: TextStyle(color: Colors.white),
          ),
        ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Column(
            children: [
              AppDropDownField(
                guideTitle: "Select Category",
                width: 150,
                dropDownHint: 'Select Category',
                dataSet: [
                  AppDropdownData(id: 1, data: 'Singer'),
                  AppDropdownData(id: 2, data: 'LG'),
                  AppDropdownData(id: 3, data: 'Damro'),
                ],
                selectedValue: _categoryType?.id, // Use null-aware operator
                onSelect: (value) {
                  setState(() {
                    _categoryType = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              AppDropDownField(
                guideTitle: "Select Device",
                width: 150,
                dropDownHint: 'Select Device',
                dataSet: [
                  AppDropdownData(id: 1, data: 'TV'),
                  AppDropdownData(id: 2, data: 'Gas Cooker'),
                  AppDropdownData(id: 3, data: 'Rice Cooker'),
                ],
                selectedValue: _deviceType?.id, // Use null-aware operator
                onSelect: (value) {
                  setState(() {
                    _deviceType = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              AppTextField(
                inputType: TextInputType.name,
                controller: deviceTypeController,
                hint: 'Device Type',
                onTextChanged: (value) {
                  setState(() {

                  });
                },
              ),
              SizedBox(height: 20,),
              AppTextField(
                inputType: TextInputType.name,
                controller: nameController,
                hint: 'Name',
                onTextChanged: (value) {
                  setState(() {
        
                  });
                },
              ),
              SizedBox(height: 20,),
              AppTextField(
                inputType: TextInputType.name,
                controller: locationController,
                hint: 'Location',
                onTextChanged: (value) {
                  setState(() {
        
                  });
                },
              ),
              SizedBox(height: 20,),
              AppTextField(
                inputType: TextInputType.name,
                controller: descriptionController,
                hint: 'Description',
                onTextChanged: (value) {
                  setState(() {
        
                  });
                },
              ),
              SizedBox(height: 20,),
              AppMobileNumberField(
                hint: 'Mobile Number',
                isRequired: true,
                focusNode: focusNode,
                initialCountryCode: phoneNumber != null
                    ? phoneNumber!.countryCode
                    .replaceAll('+', '')
                    : null,
                onChange: (phone ) {
                  setState(() {
                    if (phone.number.isNotEmpty) {
                      phoneNumber = phone;
                    } else {
                      if (phoneNumber != null) {
                        phoneNumber!.number = '';
                      }
                    }
                  });
                },
                controller: mobileNumberController, onCountryChange: (country ) {  focusNode.requestFocus(); },),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: DateComponent(icon: Icons.date_range, name: selectedFormatDate!,)),
              SizedBox(height: 50,),
              AppButton(
                buttonColor: AppColors.containerColor1,
                buttonText: 'Submit',
                onTapButton: () async {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      _categoryType != null) {
                    // Create a map with the data
                    Map<String, dynamic> jobData = {
                      'name': nameController.text,
                      'location': locationController.text,
                      'description': descriptionController.text,
                      'device_type': deviceTypeController.text,
                      'category': _categoryType!.data,
                      'device': _deviceType!.data,
                      'date': selectedFormatDate!,
                      'mobile_number': mobileNumberController.text,
                    };
        
                    // Add the data to Firestore
                    await FirebaseFirestore.instance.collection('job').
                    add(jobData);
        
                    // Clear the fields after submission
                    nameController.clear();
                    descriptionController.clear();
                    setState(() {
                      _categoryType = null;
                    });
        
                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Job created successfully!'),
                    ));
                  } else {
                    // Show an error message if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill all the fields.'),
                    ));
                  }
                },
              ),
        
            ],
          ),
        ),
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
        selectedFormatDate = DateFormat('MMM d, yyyy').format(selectedOpaimentDate);
      });
    }
  }

}
