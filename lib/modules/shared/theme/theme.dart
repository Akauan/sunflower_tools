import 'package:flutter/material.dart';

class ThemeColor {
  // Construtor privado
  // Construtor privado
  ThemeColor._();

  // Static variables to store colors based on its use in the app
  // static const primaryColor = Color(0xFF00792E);
  static const primaryColor = Color(0xFF056738);
  static const secondaryColor = Color(0xFF43BE4C);
  static final backgrondColor = const Color(0xFF056738).withOpacity(0.05);

  static const blackColor = Color(0xFF000000);
  static const whiteColor = Color(0xFFFFFFFF);
  static const greyColor = Color(0xFF707070);
  static const ligthGreenColor = Color(0xFF65D6AD);
  static const darkOrangeColor = Color(0x9CFF9800);
  static const orangeColor = Color(0xFFFF9800);
  static const pinkColor = Color(0xFFF494B6);
  static const colorShadow = Color(0xFFEFEFEF);
  static const colorBorder = Color(0xFFbdbdbd);

  static const buttonEditColor = Color(0xFFfac200);
  static const buttonConfirmColor = Color(0xFF43BE4C);
  static const buttonCancelColor = Color(0xFFFF4040);

  //Books:
// Cor do card: #a5ecb5
// Cor da onda: #4a9d66

// Favorites:
// Cor do card: #e48489
// Cor da onda: #d8646e

// Read:
// Cor do card: #b2d5ec
// Cor da onda: #78b9df

// Reviews:
// Cor do card: #ffbb64
// Cord da onda: #ffae42

  // Cards colors
  static const bookCardColor = Color(0xFFa5ecb5);
  static const bookWaveColor = Color(0xFF4a9d66);
  static const favoriteCardColor = Color(0xFFe48489);
  static const favoriteWaveColor = Color(0xFFd8646e);
  static const readCardColor = Color(0xFFb2d5ec);
  static const readWaveColor = Color(0xFF78b9df);
  static const reviewCardColor = Color(0xFFffbb64);
  static const reviewWaveColor = Color(0xFFf2ac55);

  static const warningColor = Color.fromARGB(255, 172, 59, 59);

  static const iconColor = Color(0xFF056738);

  // Table colors
  static const headerTableColor = Color(0xFFEBEBEB);
  static const bodyTableColor = Color(0xFFFFFFFF);

  static const dividerColor = Color(0xFFA9A9A9);

  static const errorColor = Color(0xFFB3261E);

  static const transparentColor = Colors.transparent;

  // Defining static variable to define the configuration of the overall visual Theme for a MaterialApp
  static final ThemeData globalTheme = ThemeData(
    // Defining primaryColor
    primaryColor: primaryColor,

    // Setting the visual density to get the value of the native SO
    visualDensity: VisualDensity.adaptivePlatformDensity,

    // Setting shades of the color scheme
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
      0xFF265631,
      <int, Color>{
        50: Color(0xFFFFFFFF),
        100: Color(0xFFFFFFFF),
        200: Color(0xFFFFFFFF),
        300: Color(0xFFFFFFFF),
        400: Color(0xFFFFFFFF),
        500: Color(0xFFFFFFFF),
        600: Color(0xFFFFFFFF),
        700: Color(0xFFFFFFFF),
        800: Color(0xFFFFFFFF),
        900: Color(0xFFFFFFFF),
      },

      //
    )).copyWith(secondary: secondaryColor),
  );
}
