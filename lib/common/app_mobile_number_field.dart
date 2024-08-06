import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../utils/app_images.dart';

class AppMobileNumberField extends StatefulWidget {
  String? initialCountryCode;
  String? hint;
  String? titleImage;
  Function(PhoneNumber) onChange;
  Function(String) onCountryChange;
  FocusNode? focusNode;
  bool? isRequired;
  bool isDisabled;
  final String? Function(String?)? validator;
  TextEditingController controller;
  final bool isPreLogin;
  final Color? bgColor;
  final bool? changeColorOnDisable;
  final String? label;

  AppMobileNumberField({
    this.initialCountryCode,
    required this.onChange,
    required this.onCountryChange,
    this.focusNode,
    this.hint,
    this.titleImage,
    this.isRequired = false,
    this.isDisabled = false,
    required this.controller,
    this.validator,
    this.isPreLogin = false,
    this.bgColor,
    this.changeColorOnDisable = false,
    this.label,

  });

  @override
  State<AppMobileNumberField> createState() => _AppMobileNumberFieldState();
}

class _AppMobileNumberFieldState extends State<AppMobileNumberField> {
  var _countryCode = const CountryCode(name: 'SL', code: 'Lk', dialCode: '+94');
  FocusNode? focusNode;
  bool hasFocus = false;

  final countryPickerWithParams = FlCountryCodePicker(
    localize: true,
    showDialCode: true,
    showSearchBar: true,
    countryTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppDimensions.kFontSize12,
      color: AppColors.fontColorGray,
    ),
    dialCodeTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppDimensions.kFontSize12,
      color: AppColors.colorIconOuter,
    ),
    searchBarTextStyle: TextStyle(
      fontSize: AppDimensions.kFontSize14,
      fontWeight: FontWeight.w600,
      color: AppColors.colorTransparent,
    ),
    title: Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            height: 4,
            width: 35,
            decoration: BoxDecoration(
              color: AppColors.fontColorPrimary,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Select country code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.fieldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    ),
    searchBarDecoration: InputDecoration(
      contentPadding: EdgeInsets.only(
        top: 11.5,
        bottom: 11.5,
        left: 11,
      ),
      isDense: true,
      counterText: "",
      hintText: 'Search',
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        borderSide: BorderSide(
          color: AppColors.colorPending,
          width: 0.75,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        borderSide: BorderSide(
          color: AppColors.fontColorGray,
          width: 0.75,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        borderSide: BorderSide(
          color: AppColors.colorDisableWidget,
          width: 0.75,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        borderSide: BorderSide(
          color: AppColors.colorDisableWidget,
          width: 0.75,
        ),
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: 55,
      ),
      suffixIconConstraints: BoxConstraints(minWidth: 24, maxHeight: 24),
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          right: 11,
        ),
        child: Image.asset(
          AppImages.icSearch,
          color: AppColors.fontColorGray,
        ),
      ),
      filled: true,
      hintStyle: TextStyle(
          color: AppColors.fontColorGray,
          fontSize: AppDimensions.kFontSize14,
          fontWeight: FontWeight.w400),
      fillColor: AppColors.fontColorGray,
    ),
  );

  getDialCode(String countryCode) {
    Country? country;
    for (var element in countries) {
      if (element.dialCode == countryCode) {
        country = element;
        break;
      }
    }
    if (country == null) {
      for (var element in countries) {
        if (element.dialCode == "94") {
          country = element;
          break;
        }
      }
    }
    setState(() {
      _countryCode = CountryCode(
        name: country!.name,
        dialCode: country.dialCode,
        code: country.code,
      );
    });
  }

  @override
  void initState() {
    if (widget.initialCountryCode != null) {
      getDialCode(widget.initialCountryCode!);
    }
    setState(() {
      focusNode = widget.focusNode ?? FocusNode();
      focusNode!.addListener(() {
        if (focusNode!.hasFocus) {
          hasFocus = true;
        } else {
          hasFocus = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.only(bottom: 6, right: 6),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       if (widget.titleImage != null)
        //         Row(
        //           children: [
        //             Image.asset(
        //               widget.titleImage!,
        //               height: 20,
        //             ),
        //             SizedBox(width: 4),
        //           ],
        //         ),
        //       Expanded(
        //         child: Row(
        //           children: [
        //             Text(
        //               (widget.label != null ? widget.label! : ''),
        //               style: TextStyle(
        //                 fontSize: AppDimensions.kFontSize14,
        //                 fontWeight: FontWeight.w500,
        //                 color: widget.isPreLogin
        //                     ? widget.changeColorOnDisable!
        //                     ? AppColors.fontColorGray
        //                     .withOpacity(0.4)
        //                     : AppColors.fontColorGray
        //                     : widget.changeColorOnDisable!
        //                     ? AppColors.fontColorGray
        //                     .withOpacity(0.4)
        //                     : AppColors.fontColorGray
        //               ),
        //             ),
        //             Baseline(
        //               baseline: 6,
        //               baselineType: TextBaseline.alphabetic,
        //               child: Text(
        //                 widget.isRequired! ? ' \u2217' : '',
        //                 style: TextStyle(
        //                   fontSize: AppDimensions.kFontSize14,
        //                   fontWeight: FontWeight.w500,
        //                   color:AppColors.fontColorGray
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        TextFormField(
          onChanged: (number) {
            widget.onChange(
              PhoneNumber(
                countryISOCode: _countryCode.code,
                countryCode: '+${_countryCode.dialCode.replaceAll('+', '')}',
                number: widget.controller.text,
              ),
            );
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: widget.validator,
          enabled: !widget.isDisabled,
          focusNode: focusNode,
          maxLength: 15,
          controller: widget.controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontSize: AppDimensions.kFontSize14,
            fontWeight: FontWeight.w500,
            color: AppColors.fontColorGray
          ),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.only(left: 11, top: 12, bottom: 12),
            isDense: true,
            counterText: "",
            disabledBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.all(
              //   Radius.circular(6),
              // ),
              borderSide: BorderSide(
                color: AppColors.fontColorWhite,
                width: 0.75,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: AppColors.fontColorWhite,
                width: 0.75,
              ),
            ),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: AppColors.fontColorWhite,
                width: 0.75,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: AppColors.fontColorGray,
                width: 0.75,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: AppColors.fontColorGray,
                width: 0.75,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: AppColors.fontColorGray,
                width: 0.75,
              ),
            ),
            errorMaxLines: 2,
            errorStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: AppDimensions.kFontSize12,
              fontWeight: FontWeight.w400,
              color: AppColors.fontColorGray,
            ),
            prefixText: widget.controller.text.isNotEmpty || hasFocus
                ? ' +${_countryCode.dialCode.replaceAll('+', '')} '
                : null,
            prefixStyle: TextStyle(
              fontSize: AppDimensions.kFontSize14,
              fontWeight: FontWeight.w500,
              color: AppColors.fontColorGray,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 48),
            prefixIcon: InkResponse(
              onTap: () async {
                final code = await countryPickerWithParams.showPicker(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: AppColors.fieldBackgroundColor,
                  pickerMaxHeight: 650,
                  scrollToDeviceLocale: true,
                );
                if (code != null) {
                  setState(() {
                    _countryCode = code;
                    widget.onCountryChange(
                        '+${_countryCode.dialCode.replaceAll('+', '')}');
                    widget.onChange(
                      PhoneNumber(
                        countryISOCode: _countryCode.code,
                        countryCode:
                        '+${_countryCode.dialCode.replaceAll('+', '')}',
                        number: widget.controller.text,
                      ),
                    );
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: 11,
                  top: 6,
                  bottom: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      _countryCode.flagUri,
                      height: 17,
                      package: _countryCode.flagImagePackage,
                    ),
                    SizedBox(width: 3),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.fontColorSuccess,
                    ),
                    SizedBox(width: 3),
                    SizedBox(
                      height: 29,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: AppColors.fieldBackgroundColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            filled: true,
            hintText: (widget.controller.text.isEmpty ? '  ' : '') +
                (widget.hint ?? ''),
            hintStyle: TextStyle(
                color: AppColors.fontColorGray,
                fontSize: AppDimensions.kFontSize12,
                fontWeight: FontWeight.w400),
            fillColor:widget.isPreLogin
                ? AppColors.fieldBackgroundColor
                : widget.bgColor != null
                ? widget.bgColor!.withOpacity(0.15)
                : AppColors.fieldBackgroundColor,
          ),
        )
      ],
    );
  }
}
