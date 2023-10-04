import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gridscape_demo/utils/constants.dart';

class EvseBox extends StatelessWidget {
  final evses;
  const EvseBox({Key? key, this.evses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.dark,
            child: Icon(
              Icons.workspaces,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            evses.connector?.first.type ?? "",
            style: GoogleFonts.poppins(
              color: AppColors.dark,
            ),
          )
        ],
      ),
    );
  }
}
