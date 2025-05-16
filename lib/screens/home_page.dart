import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/screens/carousel_animation/carousel_animation.dart';
import 'package:task_app/screens/school_management_system/school_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToPage(Widget page) {
    Navigator.of(context).push(_createRoute(page));
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return ScaleTransition(
          scale: curved,
          child: child,
        );
      },
    );
  }

  Widget svgImage({required String? name, double? height, double? width}) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height ?? 200,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(
        title: "Welcome to Task App",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          svgImage(name: "home", height: size.height / 2, width: size.width),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: CustomButton(
              label: "School Management System",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const SchoolHomePage();
                }));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: CustomButton(
                label: "Carousel3D",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Carousel3D();
                  }));
                }),
          ),
        ],
      ),
    );
  }

  Widget _animatedButton(
      {required String label,
      required VoidCallback onPressed,
      required Color color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}
