import 'package:go_router/go_router.dart';
import 'package:gridscape_demo/presentation/common_widgets/navigator_screen.dart';
import 'package:gridscape_demo/presentation/favourite/favourite.dart';
import 'package:gridscape_demo/presentation/map/map.dart';
import 'package:gridscape_demo/presentation/transacations/transactions.dart';

var router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return NavigatorScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: MapScreen.path,
          builder: (context, state) => MapScreen(),
          // routes: [
          //   GoRoute(
          //     path: WorkOrderScreen.id + "/:teamId",
          //     builder: (context, state) {
          //       String? teamId = (state.pathParameters["teamId"] ?? "");
          //       return WorkOrderScreen(
          //         isDashBoard: teamId,
          //       );
          //     },
          //   ),
          // ],
        ),
        GoRoute(
          path: FavouriteScreen.path,
          builder: (context, state) => FavouriteScreen(),
        ),
        GoRoute(
          path: TransactionScreen.path,
          builder: (context, state) => TransactionScreen(),
        ),
        GoRoute(
          path: FavouriteScreen.path,
          builder: (context, state) => FavouriteScreen(),
        ),
      ],
    ),
  ],
);
