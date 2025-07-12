// import 'dart:io';
// import 'dart:ui';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bs;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../utils/app_colors.dart';
// import '../../../utils/app_constants.dart';
// import '../../../utils/enums.dart';
// import '../common/app_dialog.dart';
//
// abstract class BaseView extends StatefulWidget {
//   BaseView({Key? key}) : super(key: key);
// }
//
// abstract class BaseViewState<Page extends BaseView> extends State<Page> {
//   Widget buildView(BuildContext context);
//
//   bool _isBottomSheetVisible = false;
//
//   bool _isProgressShow = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: ,
//     );
//   }
//
//
//   void logOut() {
//     // setState(() {
//     //   if (appSharedData.hasAppToken()) {
//     //     appSharedData.clearAppToken();
//     //   }
//     //
//     //
//     //   if (appSharedData.hasPushToken()) {
//     //     appSharedData.clearPushToken();
//     //   }
//     //
//     // });
//   }
//
//   void showAppDialog(
//       {required String title,
//         String? description,
//         AlertType alertType = AlertType.SUCCESS,
//         Color? descriptionColor,
//         String? positiveButtonText,
//         String? negativeButtonText,
//         VoidCallback? onPositiveCallback,
//         VoidCallback? onNegativeCallback,
//         bool? isDismissible,
//         Widget? widget}) {
//     if (!_isBottomSheetVisible) {
//       _isBottomSheetVisible = true;
//       bs
//           .showMaterialModalBottomSheet(
//           context: context,
//           isDismissible: false,
//           expand: false,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12))),
//           backgroundColor: Colors.transparent,
//           builder: (context) {
//             return Container(
//               /*constraints: BoxConstraints(
//                 // maxHeight: MediaQuery.of(context).size.height * 0.5,
//                 ),*/
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   color: AppColors.fontColorWhite,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12))),
//               child: AppDialog(
//                 title: title,
//                 description: description,
//                 alertType: alertType,
//                 positiveButtonText: positiveButtonText,
//                 negativeButtonText: negativeButtonText,
//                 onNegativeCallback: onNegativeCallback,
//                 onPositiveCallback: onPositiveCallback,
//                 dialogContentWidget: widget,
//               ),
//             );
//           })
//           .then((value) {
//         _isBottomSheetVisible = false;
//       });
//     }
//   }
//
//   void showCustomDialog(Widget child) {
//     if (!_isBottomSheetVisible) {
//       _isBottomSheetVisible = true;
//       bs
//           .showMaterialModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         expand: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         backgroundColor: Colors.transparent,
//         builder: (context) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               /*constraints: BoxConstraints(
//                 // maxHeight: MediaQuery.of(context).size.height * 0.5,
//                 ),*/
//               height: 500,
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: AppColors.fontColorWhite,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: child,
//             ),
//           );
//         },
//       )
//           .then((value) {
//         setState(() {
//           _isBottomSheetVisible = false;
//         });
//       });
//     }
//   }
//
//   void showLogoutDialog(Widget child) {
//     if (!_isBottomSheetVisible) {
//       _isBottomSheetVisible = true;
//       bs
//           .showMaterialModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         expand: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         backgroundColor: Colors.transparent,
//         builder: (context) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               /*constraints: BoxConstraints(
//                 // maxHeight: MediaQuery.of(context).size.height * 0.5,
//                 ),*/
//               height: 300,
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: AppColors.fontColorWhite,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: child,
//             ),
//           );
//         },
//       )
//           .then((value) {
//         setState(() {
//           _isBottomSheetVisible = false;
//         });
//       });
//     }
//   }
//
//   showProgressBar() {
//     if (!_isProgressShow) {
//       _isProgressShow = true;
//       showGeneralDialog(
//           context: context,
//           barrierDismissible: false,
//           transitionBuilder: (context, a1, a2, widget) {
//             return WillPopScope(
//               onWillPop: () async => false,
//               child: Transform.scale(
//                 scale: a1.value,
//                 child: Opacity(
//                   opacity: a1.value,
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                     child: Container(
//                       alignment: FractionalOffset.center,
//                       child: Wrap(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 25,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 4,
//                                 color: AppColors.btnGradient1,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           transitionDuration: const Duration(milliseconds: 200),
//           pageBuilder: (BuildContext context, Animation<double> animation,
//               Animation<double> secondaryAnimation) {
//             return const SizedBox.shrink();
//           });
//     }
//   }
//
//   hideProgressBar() {
//     if (_isProgressShow) {
//       Navigator.pop(context);
//       _isProgressShow = false;
//     }
//   }
//
//   showSnackBar(String message, AlertType alertType) {
//     showAppDialog(
//       title: alertType == AlertType.SUCCESS
//           ? 'Success'
//           : alertType == AlertType.FAIL
//           ? 'Failed!'
//           : 'Warning!',
//       description: message,
//     );
//     /*Flushbar flushBar = Flushbar(
//       duration: const Duration(seconds: 2),
//       messageColor: AppColors.initColors().nonChangeWhite,
//       isDismissible: true,
//       messageText: Text(
//         message,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           color: AppColors.initColors().nonChangeWhite,
//         ),
//       ),
//       boxShadows: const [
//         BoxShadow(
//           color: Color(0x0E0E0E40),
//           spreadRadius: 0,
//           blurRadius: 10,
//           offset: Offset(0, 0),
//         ),
//       ],
//       padding: EdgeInsets.symmetric(vertical: 13.5.h, horizontal: 26.w),
//       mainButton: Image.asset(
//         AppImages.icCross,
//         height: 16.h,
//       ),
//       icon: alertType == AlertType.FAIL
//           ? Image.asset(
//         AppImages.icWarningRounded,
//         height: 25.h,
//       )
//           : alertType == AlertType.SUCCESS
//           ? Image.asset(
//         AppImages.icSuccessRounded,
//         height: 25.h,
//       )
//           : Image.asset(
//         AppImages.icWarningRounded,
//         height: 25.h,
//       ),
//       backgroundColor: alertType == AlertType.FAIL
//           ? AppColors.initColors().errorRed
//           : alertType == AlertType.SUCCESS
//           ? AppColors.initColors().waitingTimeColor
//           : AppColors.initColors().warningColor,
//     );
//     if (!flushBar.isAppearing() &&
//         !flushBar.isShowing() &&
//         !flushBar.isHiding()) {
//       flushBar.show(context);
//     }*/
//   }
//
//   String getFirstCharacters(String input) {
//     List<String> words = input.split(" ");
//     if (words.length >= 2 && words[1].isNotEmpty) {
//       String firstWord = words[0];
//       String secondWord = words[1];
//       String firstCharacters =
//           "${firstWord[0].toUpperCase()}${secondWord[0].toUpperCase()}";
//       return firstCharacters;
//     } else {
//       return words[0][0] + words[0][1];
//     }
//   }
//
//   void getUserColor() {}
// }
