import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  static String id = "favourites";
  static String path = "/$id";
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Favourite Screen"),
    );
  }
}
