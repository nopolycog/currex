import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/global_providers/auth_provider.dart';
import 'package:currex/ui/router/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);

  final WidgetRef ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final AuthStatus authStatus = ref.read(authProvider);

    if (authStatus == AuthStatus.auth) {
      resolver.next();
    } else {
      resolver.redirectUntil(const SignInRoute(), replace: true);
    }
  }
}
