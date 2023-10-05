import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gridscape_demo/presentation/favourite/favourite.dart';
import 'package:gridscape_demo/presentation/map/map.dart';
import 'package:gridscape_demo/presentation/transacations/transactions.dart';
import 'package:gridscape_demo/utils/constants.dart';

class NavigatorScreen extends StatefulWidget {
  final Widget child;

  NavigatorScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MSBottomItem> icons = [];

    icons.add(MSBottomItem.map);
    icons.add(MSBottomItem.favourite);
    icons.add(MSBottomItem.transactions);
    icons.add(MSBottomItem.more);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        // padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(5.0, 5.0),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: MSBottomBar(
          icons: icons,
          currentIndex: _calculateSelectedIndex(context, icons),
          onTap: (item) => _onItemTapped(item, context),
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context, List<MSBottomItem> icons) {
    final GoRouterState route = GoRouterState.of(context);
    final String location = route.uri.toString();
    int index = -1;
    print("location $location");
    if (location == MapScreen.path) {
      index = icons.indexWhere((e) => e == MSBottomItem.map);
    } else if (location == FavouriteScreen.path) {
      index = icons.indexWhere((e) => e == MSBottomItem.favourite);
    } else if (location == TransactionScreen.path) {
      index = icons.indexWhere((e) => e == MSBottomItem.transactions);
    }
    // else if (location.startsWith(RequestScreen.path)) {
    //   index = icons.indexWhere((e) => e == MSBottomItem.request);
    // }
    print("index $index");
    return index;
  }

  void _onItemTapped(MSBottomItem item, BuildContext context) {
    switch (item) {
      case MSBottomItem.map:
        GoRouter.of(context).go(MapScreen.path);
        break;
      case MSBottomItem.favourite:
        GoRouter.of(context).go(FavouriteScreen.path);
        break;
      case MSBottomItem.transactions:
        GoRouter.of(context).go(TransactionScreen.path);
        break;
      case MSBottomItem.more:
        GoRouter.of(context).go(TransactionScreen.path);
        break;
      default:
        break;
    }
  }
}

enum MSBottomItem { map, favourite, transactions, more }

class MSBottomBar extends StatelessWidget {
  final List<MSBottomItem> icons;

  final int currentIndex;
  final void Function(MSBottomItem)? onTap;

  const MSBottomBar({Key? key, required this.icons, this.currentIndex = 0, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: Platform.isIOS ? 0 : 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: icons
                .asMap()
                .map((index, e) {
                  String label = "";
                  Widget? icon;
                  Color color = index == currentIndex ? AppColors.primary : AppColors.secondary;
                  switch (e) {
                    case MSBottomItem.map:
                      label = ModuleText.map;
                      icon = Icon(Icons.location_on, color: color, size: 20);
                      break;
                    case MSBottomItem.favourite:
                      label = ModuleText.favourite;
                      icon = Icon(Icons.star_border, color: color, size: 20);
                      break;
                    case MSBottomItem.transactions:
                      label = ModuleText.transactions;
                      icon = Icon(Icons.wallet_outlined, color: color, size: 20);
                      break;
                    case MSBottomItem.more:
                      label = ModuleText.more;
                      icon = Icon(Icons.more, color: color, size: 20);
                      break;
                    default:
                      break;
                  }
                  return MapEntry(
                    index,
                    GestureDetector(
                      onTap: () {
                        if (onTap != null) {
                          onTap!(e);
                        }
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            if (icon != null) ...[
                              icon,
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                            Text(
                              label,
                              style: GoogleFonts.poppins(
                                color: index == currentIndex ? AppColors.primary : AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
