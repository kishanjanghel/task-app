import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/repeat_fucntion/constant.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const CustomText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.overflow,
      this.fontWeight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        color: color ?? Theme.of(context).primaryColor,
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight,
      ),
    );
  }
}

class CustomLoading extends StatelessWidget {
  double? width;
  double? height;
  CustomLoading({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class CustomContainer extends StatelessWidget {
  Widget widget;
  double? height;
  double? width;
  double? radius;
  Color? color;
  AlignmentGeometry? alignmentGeometry;
  Color? borderColor;
  double? elevation;
  double? margin;
  CustomContainer(
      {super.key,
      required this.widget,
      this.height,
      this.width,
      this.radius,
      this.alignmentGeometry,
      this.borderColor,
      this.color,
      this.elevation,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignmentGeometry,
      height: height,
      width: width,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(color: Colors.grey[100]!),
      //     borderRadius: BorderRadius.circular(radius ?? 11.0)),
      child: Card(
        margin: margin == 0 ? EdgeInsets.zero : null,
        elevation: elevation,
        color: color ?? Theme.of(context).cardColor,
        // color: color ?? Colors.grey[100],
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!)),
        child: widget,
      ),
    );
  }
}

class CustomGradientContainer extends StatelessWidget {
  Widget widget;
  double? height;
  double? width;
  double? radius;
  Color? color;
  AlignmentGeometry? alignmentGeometry;
  CustomGradientContainer(
      {super.key,
      required this.widget,
      this.height,
      this.width,
      this.radius,
      this.alignmentGeometry,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: color ?? Colors.grey[100],
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: primarycolor, width: .5),
          borderRadius: BorderRadius.circular(radius ?? 11)),
      child: Container(
        alignment: alignmentGeometry,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[100]!),
            gradient: LinearGradient(
                colors: color == primarycolor
                    ? [gradientColor1, gradientColor2]
                    : [Colors.white, Colors.white]),
            borderRadius: BorderRadius.circular(radius ?? 11.0)),
        child: widget,
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  String icon;
  double? size;
  Color? color;
  bool? useTheme;
  CustomIcon(
      {super.key, required this.icon, this.color, this.size, this.useTheme});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$icon.svg",
      height: size,
      color: useTheme == true ? Theme.of(context).primaryColor : color,
    );
  }
}

class EmptyTextWidget extends StatelessWidget {
  final String msg;
  const EmptyTextWidget({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: msg,
        fontSize: 18,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
