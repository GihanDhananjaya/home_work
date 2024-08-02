import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Icon? icon;
  final Widget? action;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onTextChanged;
  final TextInputType? inputType;
  final bool? isEnable;
  final int? maxLength;
  final String? guideTitle;
  final bool? obscureText;
  final bool? shouldRedirectToNextField;
  final String? regex;
  final int? maxLines;
  final bool? isCurrency;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;

  AppTextField(
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
        this.obscureText = false,
        this.isCurrency = false,
        this.shouldRedirectToNextField = true});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  double borderRadius = 5;
  bool focusedBorder = true;
  late FocusNode _focusNode;
  Color prefixIconColor = AppColors.fontColorDark; // Initial color

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  // @override
  // void dispose() {
  //   _focusNode.removeListener(_onFocusChange);
  //   _focusNode.dispose();
  //   super.dispose();
  // }

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
        setState(() {});

        if (widget.onTextChanged != null) {
          widget.onTextChanged!(text);
        }
      },
      onSubmitted: (value) {
        if (widget.onSubmit != null) widget.onSubmit!(value);
      },
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText!,
      textInputAction: widget.shouldRedirectToNextField!
          ? TextInputAction.next
          : TextInputAction.done,
      enabled: widget.isEnable,
      maxLines: widget.maxLines,
      textCapitalization: TextCapitalization.sentences,
      maxLength: widget.maxLength,
      inputFormatters: [
        //if (widget.isCurrency!) CurrencyTextInputFormatter(symbol: ''),
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: widget.inputType ?? TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.colorDisableWidget, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorDisableWidget, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),

        contentPadding: const EdgeInsets.all(16),
        isDense: true,
        errorText: widget.errorMessage,
        counterText: "",
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
        suffixIcon: widget.action,
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
            color: AppColors.appColorAccent,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        fillColor: AppColors.fieldBackgroundColor,
      ),
    );
  }
}
