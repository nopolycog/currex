import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/common/extensions.dart';
import 'package:currex/ui/global_providers/auth_provider.dart';
import 'package:currex/ui/screens/rates_screen/rates_provider.dart';
import 'package:currex/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RatesScreen extends ConsumerStatefulWidget {
  const RatesScreen({super.key});

  @override
  ConsumerState<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends ConsumerState<RatesScreen> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(ratesProvider, (previous, next) {
      debugPrint(previous.toString());
      debugPrint(next.toString());
    });
  }

  void onTapRefresh() {
    ref.read(ratesProvider.notifier).update();
  }

  void onTapSignOut() {
    ref.watch(authProvider.notifier).logout();
    context.router.replacePath('/sign_in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rates', style: AppTextStyles().bodyMedium),
        centerTitle: true,
        leading: IconButton(
          onPressed: onTapRefresh,
          icon: Icon(Icons.refresh_rounded, color: context.colorScheme.primary),
        ),
        actions: [
          IconButton(onPressed: onTapSignOut, icon: Icon(Icons.logout_rounded, color: context.colorScheme.primary)),
        ],
      ),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Rates')])),
    );
  }
}
