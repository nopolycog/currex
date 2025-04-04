import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/router/guards/guards.dart';
import 'package:currex/ui/router/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(this.ref);

  final WidgetRef ref;

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    CustomRoute(path: '/sign_in', page: SignInRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
      path: '/',
      guards: [AuthGuard(ref)],
      page: TabBarRoute.page,
      children: [AutoRoute(path: 'rates', page: RatesRoute.page), AutoRoute(path: 'convert', page: ConvertRoute.page)],
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
