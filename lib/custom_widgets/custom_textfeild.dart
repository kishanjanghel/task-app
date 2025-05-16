import 'package:flutter/material.dart';
import 'package:task_app/repeat_fucntion/constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class CustomTextFieldValidator extends StatelessWidget {
  CustomTextFieldValidator(
      {super.key,
      required this.textEditingController,
      this.prefixIcon,
      this.suffixIcon,
      this.onPressed,
      this.obSecure,
      this.backgroundcolor,
      this.validator,
      this.keyboardType,
      this.suffix,
      this.radius,
      this.ontapField,
      required this.hintText,
      this.onchange,
      this.maxLines,
      this.borderSide,
      this.readOnly,
      this.label,
      this.prefixWidth,
      required this.formKey,
      // required this.focusNode,
      this.autoFocus});
  late MediaQueryData queryData;
  final TextEditingController textEditingController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final onPressed;
  Function()? ontapField;
  final bool? obSecure;
  final Color? backgroundcolor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffix;
  Function(String)? onchange;
  double? radius;
  int? maxLines;
  bool? autoFocus;
  BorderSide? borderSide;
  bool? readOnly;
  String? label;
  final formKey;
  double? prefixWidth;

  @override
  Widget build(BuildContext context) {
    // print("this is width ${MediaQuery.of(context).size.width * .763}");
    // print("this is height ${MediaQuery.of(context).size.height * .087}");
    queryData = MediaQuery.of(context);
    return Form(
      key: formKey,
      child: Container(
        // width: MediaQuery.of(context).size.width * .763,
        // height: MediaQuery.of(context).size.height * .077,
        child: TextFormField(
          // focusNode: focusNode,

          readOnly: readOnly ?? false,
          onTap: ontapField,
          onChanged: onchange,
          validator: validator,
          controller: textEditingController,
          obscureText: obSecure ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          style: const TextStyle(fontSize: 13),
          maxLines: maxLines ?? 1,
          autofocus: autoFocus ?? false,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            contentPadding: const EdgeInsets.only(left: 18.0, top: 18.0),
            filled: true,
            fillColor: Colors.white,
            // Theme.of(context).primaryColorLight,
            enabled: true,
            // errorText: label,
            errorBorder: OutlineInputBorder(
                borderSide: borderSide ?? const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(radius ?? 10.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: borderSide ?? const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(radius ?? 10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: borderSide ?? const BorderSide(color: primarycolor),
                borderRadius: BorderRadius.circular(radius ?? 10.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: borderSide ?? const BorderSide(color: primarycolor),
                borderRadius: BorderRadius.circular(radius ?? 10.0)),
            prefixIcon: prefixIcon == null
                ? null
                : SizedBox(
                    width: prefixWidth ?? 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        prefixIcon!,
                      ],
                    ),
                  ),
            hintStyle:
                TextStyle(fontSize: 13, color: Theme.of(context).primaryColor),
            suffix: suffix,
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child: suffixIcon ?? const SizedBox(width: 0, height: 0)),
              ],
            ),

            labelText: label,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
