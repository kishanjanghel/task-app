import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultgap = 15.0;
double defaultPadding = 16.0;
const Color primarycolor = Colors.deepPurple;
//  Color(0xff00577A);
const Color gradientColor1 = Color(0xff0077F9);
const Color gradientColor2 = Color(0xff00577A);
const Color textcolor = Color(0xff3E3E3E);
const Color darktextcolor = Color(0xff383838);
const Color lighttextcolor = Color(0xff808080);
const Color secondryColor = Color(0xff3E3E3E);
const Color blueColor = Color(0xff0077F9);
const Color greenColor = Color(0xff00c773);
const Color orangeColor = Color(0xfff99900);
const Color seachbarColor = Color(0xfff4f4f4);
const Color brownColor = Color(0xff9c703c);
const Color lightbrownColor = Color.fromARGB(255, 194, 143, 81);
Color backgroundColor = Colors.indigo[50]!;
//Chat color
Color leftChatColor = Colors.grey[300]!;
Color rightChatColor = const Color(0xffC4E9FF);

InputDecoration dropdownDecoration = InputDecoration(
    labelText: "Profile",
    labelStyle: const TextStyle(
      fontSize: 17,
      color: primarycolor,
    ),
    // prefixIcon: Icon(Icons.person),
    contentPadding: const EdgeInsets.only(left: 18.0, bottom: 8.0, right: 12.0),
    // enabled: false,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primarycolor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primarycolor),
    ));

// Themes

// light theme
final ThemeData lightTheme = ThemeData(
  dialogBackgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(buttonColor: Colors.blue // button color
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primarycolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  primaryColor: textcolor, // color for page headings
  primaryColorLight: seachbarColor, // lightish grey or black
  primaryColorDark: Colors.white, // pure white or black
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  brightness: Brightness.light,
  primaryTextTheme: const TextTheme(
      displaySmall: TextStyle(color: Colors.black), // textcolors
      displayMedium: TextStyle(color: lighttextcolor), // textcolors
      displayLarge: TextStyle(color: Colors.black)),
  dividerColor: Colors.grey,
  useMaterial3: false,
  dialogTheme: DialogTheme(
    actionsPadding: const EdgeInsets.only(
      left: 23,
      right: 23,
      top: 124,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.metrophobic(
      color: textcolor,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
      side: const BorderSide(color: Colors.blue),
    ),
    fillColor: WidgetStateColor.resolveWith((states) => Colors.white),
    checkColor: WidgetStateColor.resolveWith((states) => Colors.blue),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black, // Default color for icons
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.black, // Color for icons in app bars and primary areas
  ),
  highlightColor: const Color(0xffdde0e3),
);

// dark theme
final ThemeData darkTheme = ThemeData(
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue.shade700,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.black,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  cardColor: Colors.black,
  primaryColor: Colors.white,
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.grey.shade900,
  primarySwatch: Colors.blue,
  primaryTextTheme: TextTheme(
      displaySmall: const TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.grey.shade100),
      displayLarge: const TextStyle(color: Colors.white)),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: false,
  dialogBackgroundColor: Colors.grey.shade900,
  dividerColor: Colors.grey,
  dialogTheme: DialogTheme(
    actionsPadding: const EdgeInsets.only(
      left: 23,
      right: 23,
      top: 124,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.metrophobic(
      color: const Color(0xffE0E0E0),
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
      side: const BorderSide(color: Colors.white),
    ),
    fillColor: WidgetStateColor.resolveWith((states) => Colors.blue),
    checkColor: WidgetStateColor.resolveWith((states) => Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white, // Default color for icons
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.white, // Color for icons in app bars and primary areas
  ),
  highlightColor: Colors.black45,
);
