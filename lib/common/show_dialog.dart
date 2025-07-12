import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bs;

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../common/app_dialog.dart';

class CommonDialogUtil {
  static bool _isBottomSheetVisible = false;

  static void showAppDialog({
    required BuildContext context,
    required String title,
    String? description,
    AlertType alertType = AlertType.SUCCESS,
    Color? descriptionColor,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositiveCallback,
    VoidCallback? onNegativeCallback,
    bool? isDismissible = false,
    Widget? widget,
  }) {
    if (!_isBottomSheetVisible) {
      _isBottomSheetVisible = true;

      bs.showMaterialModalBottomSheet(
        context: context,
        isDismissible: isDismissible ?? false,
        expand: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.fontColorWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: AppDialog(
              title: title,
              description: description,
              alertType: alertType,
              positiveButtonText: positiveButtonText,
              negativeButtonText: negativeButtonText,
              onNegativeCallback: onNegativeCallback,
              onPositiveCallback: onPositiveCallback,
              dialogContentWidget: widget,
            ),
          );
        },
      ).then((_) {
        _isBottomSheetVisible = false;
      });
    }
  }
}
