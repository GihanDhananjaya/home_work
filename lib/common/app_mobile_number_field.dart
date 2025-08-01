import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';

class AppMobileNumberController extends ChangeNotifier {
  String? countryCode;
  onChangeCountryCode(String countryCode) {
    this.countryCode = countryCode;
    notifyListeners();
  }
}

class AppMobileNumberField extends StatefulWidget {
  String? initialCountryCode;
  String? title;
  Function(PhoneNumber) onChange;
  Function(String) onCountryChange;
  FocusNode? focusNode;
  TextEditingController controller;
  AppMobileNumberController? appMobileNumberController;

  AppMobileNumberField(
      {this.initialCountryCode,
        required this.onChange,
        this.title,
        required this.onCountryChange,
        this.focusNode,
        required this.controller,
        required this.appMobileNumberController});

  @override
  State<AppMobileNumberField> createState() => _AppMobileNumberFieldState();
}

class _AppMobileNumberFieldState extends State<AppMobileNumberField> {
  var _countryCode = const CountryCode(name: 'SL', code: 'SL', dialCode: '+94');
  double borderRadius = 8;

  getDialCode(String countryCode) {
    Country country = countries
        .firstWhere((element) => element.code == countryCode.toUpperCase());
    _countryCode = CountryCode(
        name: country.name, dialCode: country.dialCode, code: country.dialCode);
  }

  @override
  void initState() {
    if (widget.initialCountryCode != null) {
      getDialCode(widget.initialCountryCode!);
    }

    if (widget.appMobileNumberController != null) {
      widget.appMobileNumberController!.addListener(() {
        setState(() {
          Country country = countries.firstWhere((element) =>
          element.code ==
              widget.appMobileNumberController!.countryCode!.toUpperCase());
          _countryCode = CountryCode(
              name: country.name,
              dialCode: country.dialCode,
              code: country.dialCode);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (number) {
        widget.onChange(
          PhoneNumber(
            countryISOCode: _countryCode.code,
            countryCode: '+${_countryCode.dialCode.replaceAll('+', '')}',
            number: widget.controller.text,
          ),
        );
      },
      focusNode: widget.focusNode,
      controller: widget.controller,
      maxLength: 9,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.done,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppDimensions.kFontSize16,
        color: AppColors.fontColorDark,
      ),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          isDense: true,
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.colorDisableWidget, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.colorDisableWidget, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.colorDisableWidget, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 15,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  '+${_countryCode.dialCode.replaceAll('+', '')}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimensions.kFontSize18,
                    color: AppColors.appColorAccent,
                  ),
                ),
              ],
            ),
          ),
          filled: true,
          hintStyle: TextStyle(
              color: AppColors.colorDisableWidget,
              fontSize: AppDimensions.kFontSize12,fontWeight: FontWeight.w500),
          fillColor: AppColors.fieldBackgroundColor),
    );
  }
}
