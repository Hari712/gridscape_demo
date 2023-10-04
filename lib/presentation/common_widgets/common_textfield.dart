import 'package:flutter/material.dart';
import 'package:gridscape_demo/utils/constants.dart';

class CommonTextField extends StatelessWidget {
  final String labelText;
  const CommonTextField({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: Text(
          labelText,
          style: TextStyle(
            color: AppColors.secondary,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.secondary,
        ),
        focusColor: AppColors.secondary,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(
          color: AppColors.secondary,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
