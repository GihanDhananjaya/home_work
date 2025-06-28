import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/enums.dart';

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
  final String? initialValue;
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final bool? isCurrency;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;
  final Function()? onFocusLoss;
  final bool hasEditLock;
  final TextInputFormatter? textInputFormatter;
  final FilterType? filterType;
  final Function()? onTapEdit;

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
        this.onFocusLoss,
        this.initialValue,
        this.inputType,
        this.regex,
        this.fieldKey,
        this.focusNode,
        this.textInputFormatter,
        this.filterType,
        this.onSubmit,
        this.isEnable = true,
        this.hasEditLock = false,
        this.obscureText = false,
        this.onTapEdit,
        this.isCurrency = false,
        this.shouldRedirectToNextField = true});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  double borderRadius = 8;
  TextEditingController? _controller;
  bool focusedBorder = true;
  int totalCount = 0;
  late FocusNode _focusNode;
  bool? isEnabled;
  Color prefixIconColor = AppColors.fontColorDark; // Initial color

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      if (widget.initialValue != null) {
        widget.controller!.text = widget.initialValue!;
      }
      _controller = widget.controller;
    } else {
      if (widget.initialValue != null) {
        _controller = TextEditingController(text: widget.initialValue);
      } else {
        _controller = TextEditingController();
      }
    }

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }

    _focusNode!.addListener(() {
      if (!_focusNode!.hasFocus) {
        if (widget.onFocusLoss != null) {
          widget.onFocusLoss!();
        }
      }
    });

    isEnabled = widget.hasEditLock ? false : widget.isEnable;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: widget.maxLines!>1?Alignment.topRight:Alignment.centerRight,
          children: [
            TextField(
              onChanged: (text) {
                if (widget.isCurrency!) {
                  int commaCount = text.split(',').length - 1;
                  int dotCount = text.split('.').length - 1;
                  setState(() {
                    totalCount = commaCount + dotCount;
                  });
                }
                if (widget.onTextChanged != null) {
                  widget.onTextChanged!(text);
                }
              },
              key: widget.fieldKey,
              onSubmitted: (value) {
                if (widget.onSubmit != null) widget.onSubmit!(value);
              },
              focusNode: _focusNode,
              controller: _controller,
              obscureText: widget.obscureText!,
              textInputAction: widget.shouldRedirectToNextField!
                  ? TextInputAction.next
                  : TextInputAction.done,
              enabled: widget.isEnable,
              maxLines: widget.maxLines,
              textCapitalization: TextCapitalization.sentences,
              maxLength: widget.maxLength,
              inputFormatters: [
                if (widget.isCurrency!)
                  CurrencyTextInputFormatter.currency(symbol: ''),
                if (widget.textInputFormatter != null)
                  widget.textInputFormatter!,
                if (widget.filterType == FilterType.TYPE1)
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9,.]*$'), // Allow digits, dots, and commas.
                  ),
                if (widget.filterType == FilterType.TYPE2)
                  FilteringTextInputFormatter.allow(
                    RegExp(
                        r'[a-zA-Z\s]'), // Allow only, a to z, A to Z or a whitespace.
                  ),
                if (widget.filterType == FilterType.TYPE3)
                  FilteringTextInputFormatter.allow(
                    RegExp(
                        r'[a-zA-Z0-9\s]'), // Allow only, a to z, A to Z or a whitespace and digits.
                  ),
                if (widget.filterType == FilterType.TYPE4)
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // Only allow digits
                if (widget.filterType == FilterType.TYPE5)
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}')), // Allow integer or double
                if (widget.filterType == FilterType.TYPE6)
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[^\d]')) // Allow anything except numbers
              ],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: widget.inputType ?? TextInputType.text,
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColors.colorDisableWidget, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.fontColorDark, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.fontColorDark, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),

                contentPadding: const EdgeInsets.all(16),
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
            ),
            if (widget.action != null)
              SizedBox(
                child: widget.action!,
              )
            else if (widget.hasEditLock)
              GestureDetector(
                onTap: widget.onTapEdit ??
                        () {
                      setState(() {
                        isEnabled = true;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _focusNode!.requestFocus();
                      });
                    },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Image.asset(
                    AppImages.appMap,
                    height: 20,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
