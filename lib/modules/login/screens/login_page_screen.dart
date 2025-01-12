import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/login/controllers/login_controller.dart';
import 'package:sunflower_tools/modules/login/keys/login_keys.dart';
import 'package:sunflower_tools/modules/login/services/login_service.dart';
import 'package:sunflower_tools/modules/shared/components/form_field_component.dart';
import 'package:sunflower_tools/modules/shared/components/text_component.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';
import 'package:flutter/services.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  // Instantiating the controllers.
  final LoginController _loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();

    _loginController.clearVariables();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColor.greyColor.withOpacity(
                            0.5,
                          ),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: ThemeColor.whiteColor,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: kPaddingMedium),
                            child: TextComponent(
                              text: 'Sunflower Land Tools',
                              size: kFontSizeBig,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: kPaddingStandard, right: kPaddingStandard),
                  child: Form(
                    key: LoginKeys.formKeyLoginPag,
                    child: Column(
                      children: [
                        FormFieldComponent(
                          textInputType: TextInputType.number,
                          icon: Icons.person,
                          isRequired: true,
                          hintText: 'NFT ID or Farm ID',
                          labelText: 'NFT ID or Farm ID',
                          controller: _loginController.userLandId,
                          mask: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validation: (value) {
                            if (value == null || value == "") {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                        FormFieldComponent(
                          textInputType: TextInputType.number,
                          icon: Icons.person,
                          isRequired: true,
                          hintText: 'Refresh Time',
                          labelText: 'Refresh Time',
                          controller: _loginController.refreshTime
                            ..text = '10', // Valor padrão de 10 minutos
                          mask: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            }
                            int intValue = int.tryParse(value) ?? 0;
                            if (intValue < 10) {
                              return "The minimum value is 10";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: kPaddingSmall),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  top: kPaddingSmall,
                                  bottom: kPaddingSmall,
                                ),
                                foregroundColor: ThemeColor.whiteColor,
                                backgroundColor: ThemeColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(kRadiusMedium),
                                ),
                              ),
                              onPressed: () async {
                                if (LoginKeys.formKeyLoginPag.currentState!
                                    .validate()) {
                                  await LoginService().enterFarm(context);
                                }
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(fontSize: kFontSizeStandard),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
