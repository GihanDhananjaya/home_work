import 'package:flutter/material.dart';
import '../../../utils/enums.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final AlertType alertType;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositiveCallback;
  final VoidCallback? onNegativeCallback;
  final Widget? dialogContentWidget;

  const AppDialog({
    Key? key,
    required this.title,
    this.description,
    this.alertType = AlertType.SUCCESS,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onPositiveCallback,
    this.onNegativeCallback,
    this.dialogContentWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: isWideScreen ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: AppColors.fontColorGray,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Description
        if (description != null)
          Text(
            description!,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.fontColorGray,
            ),
          ),

        if (dialogContentWidget != null) ...[
          const SizedBox(height: 12),
          dialogContentWidget!,
        ],

        const SizedBox(height: 20),

        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (negativeButtonText != null)
              Expanded(
                child: AppButton(
                  onTapButton: () {
                    Navigator.pop(context);
                    if (onNegativeCallback != null) onNegativeCallback!();
                  },
                  buttonText: negativeButtonText!,
                ),
              ),
            const SizedBox(width: 10),
            if (positiveButtonText != null)
              Expanded(
                child: AppButton(
                  buttonText: positiveButtonText!,
                  onTapButton: (){
                    Navigator.pop(context);
                    if (onPositiveCallback != null) onPositiveCallback!();
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
