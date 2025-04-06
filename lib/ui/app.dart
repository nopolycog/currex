import 'package:currex/ui/router/router.dart';
import 'package:currex/ui/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          final AppRouter appRouter = AppRouter(ref);
          return MaterialApp.router(
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}
