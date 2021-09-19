import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme() {
  return ThemeData(
      primaryColor: kPrimaryColor,
      accentColor: kAccentColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kPrimaryColor,
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.transparent,
        elevation: .0,
        centerTitle: true,
        textTheme: textTheme(),
      ),
      chipTheme: chipThemeData(),
      toggleButtonsTheme: toggleButtonsThemeData(),
      elevatedButtonTheme: elevatedButtonThemeData(),
      outlinedButtonTheme: outlinedButtonThemeData(),
      textButtonTheme: textButtonThemeData(),
      inputDecorationTheme: inputDecorationTheme(),
      iconTheme: IconThemeData(color: Colors.white),
      colorScheme: ColorScheme.dark(

          primary: kPrimaryColor,
          secondary: kAccentColor,
          error: Colors.red,
          onSecondary: Colors.transparent),
      tabBarTheme: tabBarTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: kAccentColor.withOpacity(.6),
        selectionHandleColor: kAccentColor,
      ),
 splashColor: kAccentColor.withOpacity(.08),
              highlightColor: kAccentColor.withOpacity(.05),      );
}

TabBarTheme tabBarTheme() {
  return TabBarTheme(
      labelColor: Colors.white, unselectedLabelColor: Colors.grey);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide(color: kAccentColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    // counterStyle: TextStyle(color:Colors.red,),
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.5),
    ),
    fillColor: Colors.transparent,
    filled: true,
    contentPadding: EdgeInsets.only(
      right: 25,
    ),
    alignLabelWithHint: true,
    
  );
}

TextButtonThemeData textButtonThemeData() {
  return TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: Colors.white,
          enableFeedback: true,
          textStyle: TextStyle(color: Colors.white)));
}

OutlinedButtonThemeData outlinedButtonThemeData() {
  return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    primary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    enableFeedback: true,
    side: BorderSide(color: kAccentColor, width: 2),
  ));
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    onPrimary: Colors.white, //colors for all wiget in button and splash colors
    onSurface: kAccentColor, //Color of button

    primary: kAccentColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    enableFeedback: true,
  ));
}

ToggleButtonsThemeData toggleButtonsThemeData() {
  return ToggleButtonsThemeData(
      borderWidth: 2.5,
      fillColor: kAccentColor.withOpacity(0.05), //fill color when selected
      selectedBorderColor: kAccentColor, //Border color when selected
      selectedColor: kAccentColor, //color icon and text when selected
      splashColor: kAccentColor.withOpacity(0.12),
      hoverColor: kAccentColor.withOpacity(0.04),
      highlightColor: kAccentColor.withOpacity(0.04),
      borderRadius: BorderRadius.circular(4.0),
      constraints: BoxConstraints(minHeight: 36.0), //for main and max size

      borderColor: Colors.white.withOpacity(0.8));
}

// ChipThemeData chipThemeData() {
//   return ChipThemeData(
//     backgroundColor: kPrimaryColor,
//     labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
//     secondaryLabelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
//     selectedColor: KAccentColor,
//     disabledColor: Colors.grey,
//     brightness: Brightness.dark,
//     secondarySelectedColor: Colors.white.withOpacity(0.8),
//     pressElevation: 3,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//       side: BorderSide(color: Colors.white.withOpacity(0.8), width: 1.5),
//     ),
//     labelPadding: EdgeInsets.only(
//       right: 7,
//       top: 3,
//       bottom: 3,
//     ),
//     padding: EdgeInsets.zero,
//     elevation: 1,
//     // shadowColor: Colors.black,
//   );
// }
ChipThemeData chipThemeData() {
  return ChipThemeData(
    backgroundColor: kAccentColor,
    selectedColor: kAccentColor,
    disabledColor: Colors.grey,
    shadowColor: Colors.black,
    labelStyle: TextStyle(color: Colors.white),
    secondaryLabelStyle: TextStyle(color: Color(0xFF4A4B4D)),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: kAccentColor, width: 1.5),
    ),
    secondarySelectedColor: kPrimaryColor,
    labelPadding: EdgeInsets.only(
      right: 7,
      top: 3,
      bottom: 3,
    ),
    padding: EdgeInsets.zero,
    elevation: 1,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: GoogleFonts.almarai(
      fontSize: 99,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.white,
    ),
    headline2: GoogleFonts.almarai(
      fontSize: 62,
      fontWeight: FontWeight.w300,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.almarai(
      fontSize: 49,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.almarai(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.almarai(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.almarai(
      fontSize: 21,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.almarai(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.almarai(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.almarai(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.almarai(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.almarai(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.almarai(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.almarai(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 1.5,
    ),
  );
}

const kPrimaryColor = Color(0xFF222325);
const kAccentColor = Color(0xFF5231F2);
// const kTextBottomNav=Colors.white;
