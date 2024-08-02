import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';


class AppPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final Icon? icon;
  Widget? action;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onTextChanged;
  final TextInputType? inputType;
  final bool? isEnable;
  final int? maxLength;
  final String? guideTitle;
  final bool? shouldRedirectToNextField;
  final String? regex;
  final int? maxLines;
  final bool? isCurrency;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;

  AppPasswordField(
      {this.controller,
        this.icon,
        this.action,
        this.hint,
        this.guideTitle,
        this.errorMessage,
        this.maxLength = 50,
        this.maxLines = 1,
        this.onTextChanged,
        this.inputType,
        this.regex,
        this.focusNode,
        this.onSubmit,
        this.isEnable = true,
        this.isCurrency = false,
        this.shouldRedirectToNextField = true});

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  double borderRadius = 10;
  bool obscureText = true;
  bool focusedBorder = true;
  late FocusNode _focusNode;
  Color prefixIconColor = AppColors.fontColorDark; // Initial color

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      prefixIconColor = _focusNode.hasFocus
          ? AppColors.colorPrimary
          : AppColors.fontColorDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        setState(() {
          if (widget.regex != null && text.isEmpty) {
            widget.action = null;
          } else {
            if (widget.regex != null && widget.regex!.isNotEmpty) {
              if (RegExp(widget.regex!).hasMatch(text)) {
                widget.action = const Icon(
                  CupertinoIcons.checkmark_circle_fill,
                  color: AppColors.colorSuccess,
                );
              } else {
                widget.action = const Icon(
                  CupertinoIcons.multiply_circle_fill,
                  color: AppColors.colorFailed,
                );
              }
            }
          }
        });

        if (widget.onTextChanged != null) {
          widget.onTextChanged!(text);
        }
      },
      onSubmitted: (value) {
        if (widget.onSubmit != null) widget.onSubmit!(value);
      },
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: obscureText,
      textInputAction: widget.shouldRedirectToNextField!
          ? TextInputAction.next
          : TextInputAction.done,
      enabled: widget.isEnable,
      maxLines: widget.maxLines,
      textCapitalization: TextCapitalization.sentences,
      maxLength: widget.maxLength,
      inputFormatters: [
        //if (widget.isCurrency!) CurrencyTextInputFormatter(),
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: widget.inputType ?? TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          isDense: true,
          errorText: widget.errorMessage,
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.colorDisableWidget, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
            const BorderSide(color: AppColors.colorPrimary, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.colorDisableWidget, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 18,left: 10), // Adjust the space here
            child: widget.icon != null && widget.icon!.icon != null
                ? Icon(
              widget.icon!.icon!,
              color: prefixIconColor, // Use the updated color here
            ) : null,),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 15,
          ),
          suffixIcon: InkResponse(
              radius: 20,
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: obscureText
                    ? AppColors.colorDisableWidget
                    : AppColors.colorPrimary,
              )),
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: AppColors.appColorAccent,
              fontSize: AppDimensions.kFontSize14),
          fillColor: AppColors.fieldBackgroundColor),
    );
  }
}
