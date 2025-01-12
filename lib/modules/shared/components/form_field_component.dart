import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunflower_tools/modules/shared/components/icon_component.dart';
import 'package:sunflower_tools/modules/shared/components/rich_text_component.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class FormFieldComponent extends StatelessWidget {
  final bool obscure;
  final IconData icon;
  final String hintText;
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final List<TextInputFormatter> mask;
  final String? Function(String?)? validation;
  final Function()? onTap;
  final bool readOnly;
  final Function(String)? onChanged;
  final bool? enabled;
  final int? maxLength;
  final bool? isRequired;
  final int? maxLines;

  const FormFieldComponent({
    super.key,
    this.validation,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.suffixIcon,
    this.mask = const <TextInputFormatter>[],
    required this.icon,
    required this.textInputType,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.enabled = true,
    this.maxLength,
    this.isRequired = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled ?? true;

    return Padding(
      padding: const EdgeInsets.only(top: kPaddingStandard),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        validator: validation,
        obscureText: obscure,
        textInputAction: textInputAction,
        enabled: enabled,
        inputFormatters: mask,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          fontSize: kFontSizeMedium,
          color: isEnabled ? ThemeColor.blackColor : ThemeColor.greyColor,
          fontFamily: 'Louis George Cafe',
        ),
        decoration: InputDecoration(
          label: RichTextComponent(
            textAlign: TextAlign.center,
            textSpan: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: labelText,
                  style: const TextStyle(
                    color: ThemeColor.blackColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                isRequired!
                    ? const TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: ThemeColor.errorColor,
                        ),
                      )
                    : const TextSpan(),
              ],
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusMedium),
            borderSide: const BorderSide(
              color: ThemeColor.greyColor,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusMedium),
            borderSide: const BorderSide(
              color: ThemeColor.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusMedium),
            borderSide: const BorderSide(
              color: ThemeColor.primaryColor,
            ),
          ),
          focusColor: ThemeColor.whiteColor,
          filled: true,
          fillColor: ThemeColor.whiteColor,
          hoverColor: ThemeColor.whiteColor,
          hintStyle: const TextStyle(
              color: ThemeColor.blackColor, fontFamily: 'Louis George Cafe'),
          labelStyle: const TextStyle(
              color: ThemeColor.blackColor, fontFamily: 'Louis George Cafe'),
          suffixIcon: suffixIcon,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: kPaddingMedium,
              right: kPaddingSmall,
            ),
            child: IconComponent(
              icon: icon,
              color: ThemeColor.greyColor,
              size: kIconSizeSmall,
            ),
          ),
          prefixIconColor: ThemeColor.greyColor,
          suffixIconColor: ThemeColor.greyColor,
          hintText: labelText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusMedium),
            borderSide: const BorderSide(
              color: ThemeColor.buttonCancelColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusMedium),
            borderSide: const BorderSide(
              color: ThemeColor.buttonCancelColor,
            ),
          ),
        ),
      ),
    );
  }
}
