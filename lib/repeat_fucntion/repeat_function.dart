import 'package:flutter/material.dart';

class RepeatFunction {
  static void myShowSnakBar(
      int seconds, String text, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: color,
        duration: Duration(seconds: seconds),
        content: Text(
          text,
        )));
  }

  static Future navigatorPush(
      {required BuildContext context, required Widget pageWidget}) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => pageWidget));
  }

  void showLogoutDialog(
      {required BuildContext context, required VoidCallback ontap}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: ontap,
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
