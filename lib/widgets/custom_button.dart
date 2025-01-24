import 'package:chat_app/classes/custom_button_class.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.details, required this.onTap});
  Function() onTap;
  CustomButtonClass details;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text(
                details.ButtonText,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
