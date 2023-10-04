import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  static String id = "transactions";
  static String path = "/$id";
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Transaction Screen"),
    );
  }
}
