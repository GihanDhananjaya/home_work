import 'package:flutter/material.dart';


import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final ButtonType buttonType;
  final Widget? prefixIcon;
  final Color buttonColor;
  final Color textColor;

   AppButton(
      {required this.buttonText,
      required this.onTapButton,
      this.width = 0,
      this.prefixIcon,
        this.buttonColor = AppColors.colorPrimary,
        this.textColor = AppColors.fontColorWhite,
      this.buttonType = ButtonType.ENABLED});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  Color _buttonColor = AppColors.colorPrimary;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: MouseRegion(
        onEnter: (e){
          setState(() {
            _buttonColor = AppColors.colorHover;
          });
        },
        onExit: (e){
          setState(() {
            _buttonColor = AppColors.colorPrimary;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          width: widget.width == 0 ? double.infinity : widget.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.btnGradient1,
                AppColors.containerColor4,
              ],
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(10)),
            color: widget.buttonType == ButtonType.ENABLED
                ? widget.buttonColor
                : widget.buttonColor.withAlpha(150),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.prefixIcon ?? const SizedBox.shrink(),
                widget.prefixIcon != null
                    ? const SizedBox(
                        width: 5,
                      )
                    : const SizedBox.shrink(),
                Text(
                  widget.buttonText,
                  style: TextStyle(
                      color: widget.buttonType == ButtonType.ENABLED
                          ? widget.textColor
                          : widget.textColor.withAlpha(180),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (widget.buttonType == ButtonType.ENABLED) {
          if (widget.onTapButton != null) {
            widget.onTapButton();
          }
        }
      },
    );
  }
}
