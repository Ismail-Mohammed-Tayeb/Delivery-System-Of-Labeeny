import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kAccentColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: kPrimaryColor,
    textTheme: textTheme(),
    primaryTextTheme: TextTheme(),
    appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        elevation: .0,
        color: Colors.transparent,
        centerTitle: true,
        textTheme: textTheme()),
    chipTheme: chipThemeData(),
    toggleButtonsTheme:
        toggleButtonsThemeData(), //TODO: delelte toggleButtonsThemeData
    elevatedButtonTheme: elevatedButtonThemeData(),
    outlinedButtonTheme: outlinedButtonThemeData(),
    iconTheme: IconThemeData(color: kAccentColor),
    tabBarTheme: tabBarTheme(),
    textButtonTheme: textButtonThemeData(),
    inputDecorationTheme: inputDecorationTheme(),
    indicatorColor: kAccentColor,
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kAccentColor,
      error: Colors.red,
      onSecondary: Colors.black.withOpacity(0.2),
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: kAccentColor,
        selectionColor: kAccentColor.withOpacity(.1),
        selectionHandleColor: kAccentColor.withOpacity(.8)),

         splashColor: kAccentColor.withOpacity(.08),
              highlightColor: kAccentColor.withOpacity(.05), 
  );
}

TabBarTheme tabBarTheme() {
  return TabBarTheme(
      labelColor: kAccentColor, unselectedLabelColor: ktextFeildInputColor);
}

TextButtonThemeData textButtonThemeData() {
  return TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: kAccentColor,
          enableFeedback: true,
          textStyle: TextStyle(color: kAccentColor)));
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide(color: kAccentColor),
    gapPadding: 1,
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
      color: Color(0xFF4A4B4D),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF4A4B4D).withOpacity(0.5),
    ),
    counterStyle: TextStyle(),
    fillColor: Colors.transparent,
    filled: true,
    alignLabelWithHint: true,
    focusColor: kAccentColor,

    // ,focusColor: KAccentColor,
    contentPadding: EdgeInsets.only(right: 35),
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 2,
    onPrimary: Colors.white, //colors for all wiget in button and splash colors
    onSurface: kAccentColor, //Color of button
    primary: kAccentColor,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    enableFeedback: true,
  ));
}

OutlinedButtonThemeData outlinedButtonThemeData() {
  return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    primary: kAccentColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    enableFeedback: true,
    side: BorderSide(color: kAccentColor, width: 2),
  ));
}

ToggleButtonsThemeData toggleButtonsThemeData() {
  return ToggleButtonsThemeData(
    borderWidth: 2.5,
    fillColor: kAccentColor.withOpacity(0.08), //fill color when selected
    selectedColor: Color(0xFF4A4B4D), //color icon and text when selected
    selectedBorderColor: kAccentColor, //Border color when selected
    color: Color(0xFF4A4B4D),
    splashColor: kAccentColor.withOpacity(0.12),
    hoverColor: kAccentColor.withOpacity(0.04),
    highlightColor: kAccentColor.withOpacity(0.04),
    borderRadius: BorderRadius.circular(4.0),
    constraints: BoxConstraints(minHeight: 36.0), //for main and max size
  );
}

ChipThemeData chipThemeData() {
  return ChipThemeData(
    backgroundColor: kPrimaryColor,
    selectedColor: kAccentColor.withOpacity(.3),
    showCheckmark: true,

    checkmarkColor: kAccentColor,
    disabledColor: Colors.grey,
    shadowColor: Colors.black.withOpacity(.1),
    labelStyle: TextStyle(color: kAccentColor),
    secondaryLabelStyle: TextStyle(color: Color(0xFF4A4B4D)),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: kAccentColor, width: 1.5),
    ),
    secondarySelectedColor: kPrimaryColor,
    // labelPadding: EdgeInsets.only(
    //   right: 7,
    //   top: 3,
    //   bottom: 3,
    // ),
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
      color: Color(0xFF4A4B4D),
    ),
    headline2: GoogleFonts.almarai(
      fontSize: 62,
      fontWeight: FontWeight.w300,
      color: Color(0xFF4A4B4D),
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.almarai(
      fontSize: 49,
      color: Color(0xFF4A4B4D),
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.almarai(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.almarai(
      fontSize: 25,
      color: Color(0xFF4A4B4D),
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.almarai(
      fontSize: 21,
      fontWeight: FontWeight.w500,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.almarai(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.almarai(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.almarai(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.almarai(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.almarai(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFFffffff),
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.almarai(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF4A4B4D),
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.almarai(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: kAccentColor,
      letterSpacing: 1.5,
    ),
  );
}

const kPrimaryColor = Color(0xffffffff);
const kAccentColor = Color(0xFF5231F2);
const ktextFeildInputColor = Color(0xFF4A4B4D);
