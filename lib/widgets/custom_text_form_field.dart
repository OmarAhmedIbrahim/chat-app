// import 'package:chat_app/classes/custom_text_form_field_class.dart';
// import 'package:flutter/material.dart';
//
//
// class CustomTextFormField extends StatelessWidget {
//   CustomTextFormField(
//       {super.key, required this.details, required this.onSubmitted , this.controller , this.obscureText });
//
//   final CustomTextFormFieldClass details;
//   final Function(String) onSubmitted;
//   TextEditingController? controller ;
//   bool? obscureText  ;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         obscureText: obscureText ?? false ,
//         controller: controller,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'This field is empty ';
//           }
//         },
//         onFieldSubmitted: (value) {
//           onSubmitted(value);
//         },
//         decoration: InputDecoration(
//           hintText: details.hintText,
//           hintStyle: const TextStyle(fontWeight: FontWeight.w400),
//           label: Text(details.labelText),
//           fillColor: Colors.white,
//           filled: true,
//           border: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
//import 'package:roots/core/themes/text_themes.dart';
//import 'custom_text_form_field_prefix_icon.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.onSubmitted,
    this.controller,
    this.obscureText,
    this.hintText,
    //this.prefixIcon,
    this.validator,
    this.elevation,
  });

  final String? hintText;
  final Function(String) onSubmitted;
  final TextEditingController? controller;
  final bool? obscureText;
  //final CustomTextFormFieldPrefixIcon? prefixIcon;
  final FormFieldValidator<String>? validator;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 0,
      child: TextFormField(
        obscureText: obscureText ?? false,
        controller: controller,
        validator: validator,
        onFieldSubmitted: (value) {
          onSubmitted(value);
        },
        decoration: InputDecoration(
          errorMaxLines: 2,
         // prefixIcon: prefixIcon,
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                style: BorderStyle.none,
                width: 0
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
